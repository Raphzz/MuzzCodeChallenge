//
//  Message.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import Foundation
import SwiftData

@Model
final class Message {
    var id: String
    var content: String
    var isSender: Bool
    var timestamp: Date
    var shouldAnimate: Bool
    
    init(id: String = UUID().uuidString, content: String, isSender: Bool, timestamp: Date, shouldAnimate: Bool = false) {
        self.id = id
        self.content = content
        self.isSender = isSender
        self.timestamp = timestamp
        self.shouldAnimate = shouldAnimate
    }
}
