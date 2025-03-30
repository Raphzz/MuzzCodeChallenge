//
//  ChatMessageView.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import SwiftUI

struct ChatMessageView: View {
    var message: Message
    @State private var isAppearing = false

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
                .offset(y: isAppearing ? 0 : 60)
                .opacity(isAppearing ? 1 : 0)
                .scaleEffect(isAppearing ? 1 : 0)
                .animation(.spring(response: 0.8, dampingFraction: 0.8), value: isAppearing)

            if !message.isSender {
                Spacer()
            }
        }
        .onAppear {
            isAppearing = true
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
