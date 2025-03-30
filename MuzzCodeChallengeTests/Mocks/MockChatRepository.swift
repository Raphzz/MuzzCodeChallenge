//
//  MockChatRepository.swift
//  MuzzCodeChallengeTests
//
//  Created by Raphael Velasqua on 30/03/2025.
//

@testable import MuzzCodeChallenge
import Foundation

final class MockChatRepository: ChatRepositoryProtocol {

    var didCallSaveMessage = false
    var didCallSaveMessages = false
    var didCallFetchMessages = false

    func saveMessage(_ message: Message) async throws {
        didCallSaveMessage = true
    }

    func saveMessages(_ messages: [Message]) async throws {
        didCallSaveMessages = true
    }

    func fetchMessages() async throws -> [Message] {
        didCallFetchMessages = true

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
