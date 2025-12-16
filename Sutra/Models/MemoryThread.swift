//
//  MemoryThread.swift
//  Sutra
//
//  Model for user memory entries
//
//  Created by Aryan Vyahalkar on 11/20/25.
//

import Foundation

struct MemoryThread: Identifiable {
    let id = UUID()
    let text: String
    let angle: Double
    let timestamp: Date = Date()
}
