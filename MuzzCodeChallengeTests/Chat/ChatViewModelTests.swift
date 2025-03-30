//
//  ChatViewModelTests.swift
//  MuzzCodeChallengeTests
//
//  Created by Raphael Velasqua on 30/03/2025.
//

import Testing
@testable import MuzzCodeChallenge

struct ChatViewModelTests {
    
    @Test("ChatViewModel should initialize with correct title")
    func testInitialization() async throws {
        // Given
        let mockRepository = MockChatRepository()
        let sut = ChatViewModel(repository: mockRepository)
        
        // Then
        #expect(sut.title == "chat.title".localized)
        #expect(sut.messages.isEmpty)
        #expect(sut.textInput.isEmpty)
        #expect(sut.isSender)
        #expect(!sut.isLoading)
    }
    
    @Test("ChatViewModel should load messages successfully")
    func testLoadMessages() async throws {
        // Given
        let mockRepository = MockChatRepository()
        let sut = ChatViewModel(repository: mockRepository)
        
        // When
        try await sut.loadMessages()
        
        // Then
        #expect(mockRepository.didCallFetchMessages)
        #expect(!sut.messages.isEmpty)
        #expect(sut.messages.count == 7) // Based on mock data
    }
    
    @Test("ChatViewModel should send message successfully")
    func testSendMessage() async throws {
        // Given
        let mockRepository = MockChatRepository()
        let sut = ChatViewModel(repository: mockRepository)
        let messageText = "Hello, World!"
        sut.textInput = messageText
        
        // When
        await sut.sendMessage()
        
        // Then
        #expect(mockRepository.didCallSaveMessage)
        #expect(sut.textInput.isEmpty)
        #expect(sut.messages.count == 1)
        #expect(sut.messages.first?.content == messageText)
        #expect(sut.messages.first?.isSender == true)
    }
    
    @Test("ChatViewModel should not send empty message")
    func testSendEmptyMessage() async throws {
        // Given
        let mockRepository = MockChatRepository()
        let sut = ChatViewModel(repository: mockRepository)
        sut.textInput = "   "
        
        // When
        await sut.sendMessage()
        
        // Then
        #expect(!mockRepository.didCallSaveMessage)
        #expect(sut.messages.isEmpty)
    }

    @Test("ChatViewModel should group messages correctly")
    func testMessageGrouping() async throws {
        // Given
        let mockRepository = MockChatRepository()
        let sut = ChatViewModel(repository: mockRepository)

        // When
        try await sut.loadMessages()

        // Then
        #expect(!sut.messageGroups.isEmpty)
        #expect(sut.messageGroups.count == 3) // Based on mock data timestamps
    }
}
