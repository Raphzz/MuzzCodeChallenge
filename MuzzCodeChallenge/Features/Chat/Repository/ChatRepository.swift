//
//  ChatRepository.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 28/03/2025.
//

import Foundation
import SwiftData

protocol ChatRepositoryProtocol {
    func saveMessage(_ message: Message) async throws
    func saveMessages(_ messages: [Message]) async throws
    func fetchMessages() async throws -> [Message]
}

final class ChatRepository: ChatRepositoryProtocol {

    private var modelContainer: ModelContainer?
    private var modelContext: ModelContext?
    
    init() {

        // MARK: Repository should check for connectivity and fetch remote Chat history. If fails proceed to setup SwiftData DB

//        guard Connectivity().isOnline else {
//            setupContainer()
//            return
//        }
//
//        let chatHistory = await NetworkManagerProtocol().fetchChatHistory()

        setupContainer()
    }
    
    private func setupContainer() {
        do {
            let schema = Schema([Message.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if let container = modelContainer {
                self.modelContext = ModelContext(container)
            }
        } catch {
            print("Failed to setup SwiftData container: \(error)")
        }
    }
    
    // MARK: - ChatRepositoryProtocol

    @MainActor
    func saveMessage(_ message: Message) async throws {
        guard let context = modelContext else {
            throw ChatRepositoryError.contextUnavailable
        }
        
        context.insert(message)
        try context.save()
    }

    @MainActor
    func saveMessages(_ messages: [Message]) async throws {
        guard let context = modelContext else {
            throw ChatRepositoryError.contextUnavailable
        }

        messages.forEach { context.insert($0) }
        try context.save()
    }

    @MainActor
    func fetchMessages() async throws -> [Message] {
        guard let context = modelContext else {
            throw ChatRepositoryError.contextUnavailable
        }
        
        let descriptor = FetchDescriptor<Message>(
            sortBy: [SortDescriptor(\.timestamp, order: .forward)]
        )

        let messages = try context.fetch(descriptor)
        guard messages.isEmpty == false else {
            try await saveMessages(ChatRepository.mockData())
            return ChatRepository.mockData()
        }

        return try context.fetch(descriptor)
    }
}

// MARK: - Errors

enum ChatRepositoryError: LocalizedError {
    case contextUnavailable
    
    var errorDescription: String? {
        switch self {
        case .contextUnavailable:
            return "Database context is not available"
        }
    }
}

// MARK: - ChatRepository extension

extension ChatRepository {
    static func mockData() -> [Message] {
        let yesterday = Date().addingTimeInterval(-.twentyFourHours)
        let mockMessages: [Message] = [
            Message(
                content: "Hey! How are you? 👋",
                isSender: false,
                timestamp: yesterday.addingTimeInterval(-.twoHour) // 2 hours ago
            ),
            Message(
                content: "I'm doing great!",
                isSender: true,
                timestamp: yesterday.addingTimeInterval(-.oneHour) // 1 hour ago
            ),
            Message(
                content: "Thanks for asking 😊",
                isSender: true,
                timestamp: yesterday
                    .addingTimeInterval(
                        -(.oneHour + .tenSeconds)
                    ) // 10 seconds after previous
            ),
            Message(
                content: "The new app looks amazing",
                isSender: false,
                timestamp: yesterday
                    .addingTimeInterval(-.fiveMinutes) // 5 minutes ago
            ),
            Message(
                content: "Have you seen all the features?",
                isSender: false,
                timestamp: yesterday
                    .addingTimeInterval(
                        -(.fiveMinutes + .tenSeconds)
                    ) // 10 seconds after previous
            ),
            Message(
                content: "Yes! Love the new chat",
                isSender: true,
                timestamp: yesterday.addingTimeInterval(-.fiveMinutes) // 5 minutes ago
            ),
            Message(
                content: "Especially the message grouping",
                isSender: true,
                timestamp: yesterday
                    .addingTimeInterval(
                        -.oneMinute
                    ) // 1 minute ago
            )
        ]

        return mockMessages
    }
}
