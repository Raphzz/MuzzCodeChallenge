//
//  ChatViewModel.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import Combine
import Foundation

@MainActor
final class ChatViewModel: ObservableObject {

    // MARK: Private properties

    private let repository: ChatRepositoryProtocol

    // MARK: Public properties

    var title: String = "chat.title".localized

    // MARK: Published properties

    @Published var messages: [Message] = []
    @Published var textInput: String = ""
    @Published var isSender: Bool = true
    @Published var isLoading: Bool = false

    // MARK: Computed properties

    var messageGroups: [MessageGroup] {
        let calendar = Calendar.current
        let groupedMessages = Dictionary(grouping: messages) { message -> Date in
            calendar.date(bySetting: .minute, value: 0, of: message.timestamp) ?? message.timestamp
        }
        
        return groupedMessages
            .map { MessageGroup(timestamp: $0.key, messages: $0.value.sorted(by: { $0.timestamp < $1.timestamp })) }
            .sorted(by: { $0.timestamp < $1.timestamp })
    }

    // MARK: init

    init(repository: ChatRepositoryProtocol = ChatRepository()) {
        self.repository = repository
    }

    // MARK: Public functions

    func sendMessage() async {
        guard !textInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let newMessage = Message(
            content: textInput,
            isSender: isSender,
            timestamp: Date(),
            shouldAnimate: true
        )

        do {
            let messageToSave = Message(
                content: textInput,
                isSender: isSender,
                timestamp: Date(),
                shouldAnimate: false
            )

            try await repository.saveMessage(messageToSave)
            messages.append(newMessage)
            textInput = ""
        } catch {
            print("Failed to save message: \(error)")
        }
    }

    func loadMessages() async throws {
        messages = try await repository.fetchMessages()
    }

    @MainActor
    func shouldGroupWithNextMessage(at index: Int, in group: MessageGroup) -> Bool {
        guard index < group.messages.count - 1 else { return false }

        let currentMessage = group.messages[index]
        let nextMessage = group.messages[index + 1]

        return currentMessage.isSender == nextMessage.isSender &&
               nextMessage.timestamp.timeIntervalSince(currentMessage.timestamp) <= 20
    }
}
