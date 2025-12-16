//
//  Scene1Place.swift
//  Sutra
//
//  Scene 1: Thread of Place - Tap to reveal words
//
//  Created by Aryan Vyahalkar on 12/01/25.
//

import SwiftUI

struct Scene1Place: View {
    @Environment(AppState.self) private var appState
    @State private var ripples: [Ripple] = []
    
    var body: some View {
        ZStack {
            // Background
            Color.backgroundGradient
                .ignoresSafeArea()
            
            // Ripple effects
            ForEach(ripples) { ripple in
                RippleShape(progress: ripple.progress)
                    .stroke(Color.threadGradient, lineWidth: 2)
                    .frame(width: 100, height: 100)
                    .position(ripple.position)
                    .opacity(1 - ripple.progress)
            }
            
            // Revealed words
            VStack(spacing: 40) {
                ForEach(Array(appState.placeWords.enumerated()), id: \.element.id) { index, word in
                    if word.revealed {
                        WordRevealView(word: word)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .padding()
            
            // Instruction text at bottom
            VStack {
                Spacer()
                if appState.revealedWordCount == 0 {
                    Text("Tap to begin")
                        .font(.englishSubtle)
                        .foregroundColor(.subtleGray.opacity(0.6))
                        .padding(.bottom, 50)
                }
            }
            .allowsHitTesting(false)
        }
        .contentShape(Rectangle())
        .onTapGesture { location in
            handleTap(at: location)
        }
    }
    
    private func handleTap(at location: CGPoint) {
        
        HapticManager.shared.light()
        
        let ripple = Ripple(position: location)
        ripples.append(ripple)
        
        withAnimation(.easeOut(duration: 1.5)) {
            if let index = ripples.firstIndex(where: { $0.id == ripple.id }) {
                ripples[index].progress = 1.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            ripples.removeAll { $0.id == ripple.id }
        }
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
            appState.revealNextWord()
        }
        
        if appState.revealedWordCount > 0 {
            HapticManager.shared.medium()
        }
        
        if appState.revealedWordCount == appState.placeWords.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                HapticManager.shared.heavy()
                withAnimation {
                    appState.nextScene()
                }
            }
        }
    }
    
    // MARK: - Ripple Data Model
    struct Ripple: Identifiable {
        let id = UUID()
        let position: CGPoint
        var progress: Double = 0.0
    }
    
    // MARK: - Ripple Shape
    struct RippleShape: Shape {
        var progress: Double
        
        var animatableData: Double {
            get { progress }
            set { progress = newValue }
        }
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let radius = min(rect.width, rect.height) / 2 * progress
            path.addEllipse(in: CGRect(
                x: rect.midX - radius,
                y: rect.midY - radius,
                width: radius * 2,
                height: radius * 2
            ))
            return path
        }
    }
    
    struct Scene1Place_Previews: PreviewProvider {
        static var previews: some View {
            Scene1Place()
                .environment(AppState())
        }
    }
}
