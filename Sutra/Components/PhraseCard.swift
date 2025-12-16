//
//  PhraseCard.swift
//  Sutra
//
//  Component for displaying connectable phrase pairs
//
//  Created by Aryan Vyahalkar on 11/13/25.
//

import SwiftUI

struct PhraseCard: View {
    let phrase: Phrase
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            SpeechManager.shared.speak(phrase.marathi)
            onTap()
        }) {
            VStack(spacing: 20) {
                Text(phrase.marathi)
                    .font(.marathiMedium)
                    .foregroundStyle(Color.threadGradient)
                
                if phrase.connected {
                    ThreadLine()
                        .stroke(Color.threadGradient, lineWidth: 2)
                        .frame(height: 40)
                        .transition(.scale.combined(with: .opacity))
                }
                
                Text(phrase.english)
                    .font(.englishSubtle)
                    .foregroundColor(phrase.connected ? .subtleGray : .subtleGray.opacity(0.3))
            }
            .padding(.horizontal, 40)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Thread Line Shape
struct ThreadLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Create a gentle wave connecting the phrases
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        
        path.addCurve(
            to: CGPoint(x: rect.maxX, y: rect.maxY),
            control1: CGPoint(x: rect.midX - 30, y: rect.midY - 10),
            control2: CGPoint(x: rect.midX + 30, y: rect.midY + 10)
        )
        
        return path
    }
}

#Preview {
    ZStack {
        Color.backgroundGradient
            .ignoresSafeArea()
        
        VStack(spacing: 40) {
            PhraseCard(
                phrase: Phrase(marathi: "कस आहेस?", english: "How are you?", connected: false),
                onTap: {}
            )
            
            PhraseCard(
                phrase: Phrase(marathi: "सगळं ठीक आहे.", english: "Everything's okay.", connected: true),
                onTap: {}
            )
        }
    }
}
