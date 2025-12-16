//
//  AppState.swift
//  Sutra
//
//  Observable state management for the entire app
//
//  Created by Aryan Vyahalkar on 12/09/25.
//

import SwiftUI

@Observable
class AppState {
    
    var currentScene: Int = 1
    
    var placeWords: [Word] = [
        Word(marathi: "घर", english: "home"),
        Word(marathi: "मूळ", english: "roots"),
        Word(marathi: "संबंध", english: "belonging"),
        Word(marathi: "प्रवास", english: "journey")
    ]
    var revealedWordCount: Int = 0
    
    var phrases: [Phrase] = [
        Phrase(marathi: "कस आहेस?", english: "How are you?"),
        Phrase(marathi: "सगळं ठीक आहे.", english: "Everything's okay."),
        Phrase(marathi: "चल भेटूया.", english: "Let's meet soon.")
    ]
    
    var memoryThreads: [MemoryThread] = []
    
    func nextScene() {
        if currentScene < 4 {
            currentScene += 1
        }
    }
    
    func revealNextWord() {
        if revealedWordCount < placeWords.count {
            placeWords[revealedWordCount].revealed = true
            revealedWordCount += 1
        }
    }
    
    func connectPhrase(at index: Int) {
        if index < phrases.count {
            phrases[index].connected = true
        }
    }
    
    func addMemory(_ text: String) {
        let angle = Double(memoryThreads.count) * (360.0 / 8.0)
        let memory = MemoryThread(text: text, angle: angle)
        memoryThreads.append(memory)
    }
    
    func reset() {
        currentScene = 1
        revealedWordCount = 0
        
        for i in 0..<placeWords.count {
            placeWords[i].revealed = false
        }
        
        for i in 0..<phrases.count {
            phrases[i].connected = false
        }
        
        memoryThreads.removeAll()
    }
}
