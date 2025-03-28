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
                .background(message.isSender ? Color.blue : Color.gray)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(message.isSender ? .leading : .trailing, 55)

            if !message.isSender {
                Spacer()
            }
        }
    }
}
