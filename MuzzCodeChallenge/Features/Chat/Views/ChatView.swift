//
//  ChatView.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ChatViewModel()
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        VStack {
            ScrollView {
                ScrollViewReader { scrollView in
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            ChatMessageView(message: message)
                                .id(message.id)
                        }
                    }
                    .onReceive(viewModel.$messages) { _ in
                        withAnimation {
                            scrollView.scrollTo(viewModel.messages.last?.id)
                        }
                    }
                }
            }
            .padding(.bottom, keyboardHeight)

            InputBarView(text: $viewModel.textInput) {
                viewModel.sendMessage()
            }

            if let animatingMessage = viewModel.animatingMessage {
                ChatMessageView(message: animatingMessage)
                    .offset(y: -keyboardHeight)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut(duration: 0.3))
            }
        }
        .navigationTitle("chat.title".localized)
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
                let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                keyboardHeight = height
            }

            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                keyboardHeight = 0
            }
        }
    }
}

#Preview {
    NavigationView {
        ChatView(viewModel: ChatViewModel())
    }
}
