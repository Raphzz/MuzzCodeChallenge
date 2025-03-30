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
                .offset(y: message.shouldAnimate ? (isAppearing ? 0 : 60) : 0)
                .opacity(message.shouldAnimate ? (isAppearing ? 1 : 0) : 1)
                .scaleEffect(message.shouldAnimate ? (isAppearing ? 1 : 0) : 1)

            if !message.isSender {
                Spacer()
            }
        }
        .onAppear {
            if message.shouldAnimate {
                withAnimation {
                    isAppearing = true

                    // Set shouldAnimate to false after animation completes
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.message.shouldAnimate = false
                    }
                }
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
