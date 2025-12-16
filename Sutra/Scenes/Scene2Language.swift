//
//  Scene2Language.swift
//  Sutra
//
//  Scene 2: Thread of Language - Connect phrases
//
//  Created by Aryan Vyahalkar on 12/07/25.
//

import SwiftUI

struct Scene2Language: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        ZStack {
            Color.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                
                Text("Thread of Language")
                    .font(.marathiMedium)
                    .foregroundStyle(Color.threadGradient)
                    .padding(.top, 60)
                
                Spacer()
                
                VStack(spacing: 40) {
                    ForEach(Array(appState.phrases.enumerated()), id: \.element.id) { index, phrase in
                        PhraseCard(phrase: phrase) {
                            HapticManager.shared.medium()
                            
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                appState.connectPhrase(at: index)
                            }
                            
                            if appState.phrases.allSatisfy({ $0.connected }) {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    HapticManager.shared.heavy()
                                    withAnimation {
                                        appState.nextScene()
                                    }
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Instruction
                if !appState.phrases.allSatisfy({ $0.connected }) {
                    Text("Tap to connect")
                        .font(.englishSmall)
                        .foregroundColor(.subtleGray.opacity(0.6))
                        .padding(.bottom, 40)
                }
            }
        }
    }
}

struct Scene2Language_Previews: PreviewProvider {
    static var previews: some View {
        Scene2Language()
            .environment(AppState())
    }
}
