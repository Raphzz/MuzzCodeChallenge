//
//  ChatView.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import SwiftUI

struct ChatView: View {

    // MARK: ViewModel

    @ObservedObject var viewModel = ChatViewModel.mock()

    // MARK: body

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                messageList

                InputBarView(text: $viewModel.textInput) {
                    viewModel.sendMessage()
                }
                .frame(height: 70)
            }
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Toggle(isOn: $viewModel.isSender) {
                    Image(systemName: viewModel.isSender ? "person.fill" : "person.2.fill")
                }
                .toggleStyle(SwitchToggleStyle(tint: Color(Theme.mainColor)))
            }
        }
    }

    // MARK: Private properties

    private var messageList: some View {
        ScrollView {
            ScrollViewReader { scrollView in
                LazyVStack {
                    ForEach(viewModel.messages) { message in
                        ChatMessageView(message: message)
                            .id(message.id)
                            .padding(.horizontal)
                    }
                }
                .onReceive(viewModel.$messages) { _ in
                    withAnimation {
                        scrollView.scrollTo(viewModel.messages.last?.id)
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

// MARK: Preview

#Preview {
    NavigationView {
        ChatView(viewModel: ChatViewModel())
    }
}
