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
    @Published var animatingMessage: Message?

    func sendMessage() {
        let newMessage = Message(content: self.textInput, isSender: true, timestamp: Date())
        self.animatingMessage = newMessage
        self.textInput = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.messages.append(newMessage)
            self.animatingMessage = nil
        }
    }
}
