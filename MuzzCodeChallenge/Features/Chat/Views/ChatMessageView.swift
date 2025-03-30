//
//  ChatMessageView.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import SwiftUI

struct ChatMessageView: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isSender {
                Spacer()
            }

            Text(message.content)
                .padding()
                .background(message.isSender ? Theme.mainColor : Color.gray)
                .cornerRadius(20)
                .foregroundColor(.white)
                .padding(message.isSender ? .leading : .trailing, 55)

            if !message.isSender {
                Spacer()
            }
        }
    }
}

#Preview {
    ChatMessageView(
        message: Message(
            id: "",
            content: "This is a test message",
            isSender: true,
            timestamp: Date()
        )
    )
}
