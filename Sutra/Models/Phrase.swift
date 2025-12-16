//
//  Phrase.swift
//  Sutra
//
//  Model for Marathi-English phrase pairs
//
//  Created by Aryan Vyahalkar on 11/24/25.
//

import Foundation

struct Phrase: Identifiable {
    let id = UUID()
    let marathi: String
    let english: String
    var connected: Bool = false
}
