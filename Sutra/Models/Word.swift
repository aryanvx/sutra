//
//  Word.swift
//  Sutra
//
//  Model for Marathi-English word pairs
//
//  Created by Aryan Vyahalkar on 11/26/25.
//


import Foundation

struct Word: Identifiable {
    let id = UUID()
    let marathi: String
    let english: String
    var revealed: Bool = false
}
