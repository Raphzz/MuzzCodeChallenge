//
//  Message.swift
//  MuzzCodeChallenge
//
//  Created by Raphael Velasqua on 27/03/2025.
//

import Foundation

struct Message: Identifiable {
    var id: String = UUID().uuidString
    var content: String
    var isSender: Bool
    var timestamp: Date
}
