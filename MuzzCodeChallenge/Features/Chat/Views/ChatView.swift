//
//  ChatView.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import SwiftUI

struct ChatView: View {

    // MARK: ViewModel

    @ObservedObject var viewModel = ChatViewModel()

    // MARK: body

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                messageList
                InputBarView(text: $viewModel.textInput) {
                    Task {
                        await viewModel.sendMessage()
                    }
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
        .onAppear() {
            Task {
                do {
                    try await viewModel.loadMessages()
                } catch {
                    print("Error loading messages: \(error)")
                }
            }
        }
    }

    // MARK: Private properties

    private var messageList: some View {
        ScrollView {
            ScrollViewReader { scrollView in
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.messageGroups) { group in
                        VStack(alignment: .center, spacing: 0) {
                            Text(group.formattedTimestamp)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.vertical, 8)
                            
                            ForEach(Array(zip(group.messages.indices, group.messages)), id: \.1.id) { index, message in
                                ChatMessageView(message: message)
                                    .id(message.id)
                                    .padding(.horizontal)
                                    .padding(.bottom, viewModel.shouldGroupWithNextMessage(at: index, in: group) ? 2 : 8)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

// MARK: Preview

#Preview {
    NavigationView {
        ChatView()
    }
}
