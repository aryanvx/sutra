//
//  WordRevealView.swift
//  Sutra
//
//  Component for displaying revealed Marathi words with gradient
//
//  Created by Aryan Vyahalkar on 11/12/25.
//

import SwiftUI

struct WordRevealView: View {
    let word: Word
    @State private var glowIntensity: Double = 0.0
    
    var body: some View {
        VStack(spacing: 12) {
            Text(word.marathi)
                .font(.marathiLarge)
                .foregroundStyle(Color.threadGradient)
                .shadow(color: Color.saffron.opacity(glowIntensity), radius: 20)
                .shadow(color: Color.gold.opacity(glowIntensity), radius: 40)
                .onTapGesture {
                    SpeechManager.shared.speak(word.marathi)
                    HapticManager.shared.light()
                }
            
            Text(word.english)
                .font(.englishSubtle)
                .foregroundColor(.subtleGray)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                glowIntensity = 0.4
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                SpeechManager.shared.speak(word.marathi)
            }
        }
    }
}

struct WordRevealView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.backgroundGradient
                .ignoresSafeArea()
            
            WordRevealView(word: Word(marathi: "घर", english: "home", revealed: true))
        }
    }
}
