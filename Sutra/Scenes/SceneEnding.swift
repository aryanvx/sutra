//
//  SceneEnding.swift
//  Sutra
//
//  Ending Scene: Final reflection w/ woven pattern
//
//  Created by Aryan Vyahalkar on 12/16/25.
//

import SwiftUI

struct SceneEnding: View {
    @Environment(AppState.self) private var appState
    @State private var textOpacity: Double = 0.0
    @State private var patternOpacity: Double = 0.0
    
    var body: some View {
        ZStack {
            Color.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 60) {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Every word is a thread")
                        .font(.marathiMedium)
                        .foregroundStyle(Color.threadGradient)
                        .multilineTextAlignment(.center)
                        .opacity(textOpacity)
                    
                    Text("every thread leads home")
                        .font(.englishSubtle)
                        .foregroundColor(.subtleGray)
                        .multilineTextAlignment(.center)
                        .opacity(textOpacity)
                }
                .padding(.horizontal, 40)
                
                WovenPattern()
                    .frame(height: 300)
                    .padding(.horizontal, 40)
                    .opacity(patternOpacity)
                
                Spacer()
                
                // Restart button
                Button(action: restartJourney) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.counterclockwise")
                        Text("Begin Again")
                    }
                    .font(.englishSubtle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(Color.threadGradient)
                    .cornerRadius(25)
                }
                .padding(.bottom, 40)
                .opacity(textOpacity)
            }
        }
        .onAppear {
            // Fade in text
            withAnimation(.easeIn(duration: 1.5)) {
                textOpacity = 1.0
            }
            
            // Fade in pattern after text
            withAnimation(.easeIn(duration: 1.5).delay(0.8)) {
                patternOpacity = 1.0
            }
        }
    }
    
    private func restartJourney() {
        HapticManager.shared.success()
        withAnimation {
            appState.reset()
        }
    }
}

struct SceneEnding_Previews: PreviewProvider {
    static var previews: some View {
        SceneEnding()
            .environment(AppState())
    }
}
