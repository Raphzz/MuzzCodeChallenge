//
//  ChatViewModel.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import Combine
import Foundation

class ChatViewModel: ObservableObject {

    // MARK: Public properties

    let title: String = "chat.title".localized

    // MARK: Published properties

    @Published var messages: [Message] = []
    @Published var textInput: String = ""
    @Published var isSender: Bool = true

    // MARK: Published functions

    @MainActor
    func sendMessage() {
        let newMessage = Message(content: self.textInput, isSender: isSender, timestamp: Date())
        self.textInput = ""

        self.messages.append(newMessage)
    }

    static func mock() -> ChatViewModel {
        let mockVm = ChatViewModel()

        let now = Date()
        mockVm.messages = [
            Message(
                content: "Hey! How are you? 👋",
                isSender: false,
                timestamp: now.addingTimeInterval(-3600) // 1 hour ago
            ),
            Message(
                content: "I'm doing great, thanks for asking! How about you?",
                isSender: true,
                timestamp: now.addingTimeInterval(-3540) // 59 minutes ago
            ),
            Message(
                content: "Pretty good! Did you see the new updates to the app?",
                isSender: false,
                timestamp: now.addingTimeInterval(-3480) // 58 minutes ago
            ),
            Message(
                content: "Yes! The new design looks amazing 😍",
                isSender: true,
                timestamp: now.addingTimeInterval(-3420) // 57 minutes ago
            ),
            Message(
                content: "I especially love the new chat features. The animations are so smooth!",
                isSender: true,
                timestamp: now.addingTimeInterval(-3419) // Right after previous message
            ),
            Message(
                content: "Totally agree! The team did an incredible job 🚀",
                isSender: false,
                timestamp: now.addingTimeInterval(-3300) // 55 minutes ago
            ),
            Message(
                content: "By the way, have you tried the new toggle feature? You can switch between sender modes!",
                isSender: false,
                timestamp: now.addingTimeInterval(-180) // 3 minutes ago
            ),
            Message(
                content: "Testing it right now! It's perfect for debugging 🛠️",
                isSender: true,
                timestamp: now.addingTimeInterval(-60) // 1 minute ago
            )
        ]
        return mockVm
    }
}
