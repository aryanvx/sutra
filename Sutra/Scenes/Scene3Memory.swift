//
//  Scene3Memory.swift
//  Sutra
//
//  Scene 3: Thread of Memory - User input creates visual threads
//
//  Created by Aryan Vyahalkar on 12/07/25.
//

import SwiftUI

struct Scene3Memory: View {
    @Environment(AppState.self) private var appState
    @State private var inputText: String = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundGradient
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                
                Text("Thread of Memory")
                    .font(.marathiMedium)
                    .foregroundStyle(Color.threadGradient)
                    .padding(.top, 60)
                
                Text("What reminds you of home?")
                    .font(.englishSubtle)
                    .foregroundColor(.subtleGray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                if !appState.memoryThreads.isEmpty {
                    MemoryCircle(threads: appState.memoryThreads)
                        .frame(height: 350)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    TextField("Type a memory...", text: $inputText)
                        .font(.bodyText)
                        .padding()
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(12)
                        .focused($isInputFocused)
                        .submitLabel(.done)
                        .onSubmit {
                            submitMemory()
                        }
                    
                    Button(action: submitMemory) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 32))
                            .foregroundStyle(Color.threadGradient)
                    }
                    .disabled(inputText.trimmingCharacters(in: .whitespaces).isEmpty)
                    .opacity(inputText.trimmingCharacters(in: .whitespaces).isEmpty ? 0.3 : 1.0)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
                
                if appState.memoryThreads.count >= 3 {
                    Button(action: {
                        HapticManager.shared.heavy()
                        withAnimation {
                            appState.nextScene()
                        }
                    }) {
                        Text("Continue to Reflection")
                            .font(.englishSubtle)
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background(Color.threadGradient)
                            .cornerRadius(25)
                    }
                    .padding(.bottom, 20)
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .onTapGesture {
            isInputFocused = false
        }
    }
    
    private func submitMemory() {
        let trimmed = inputText.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return }
        
        HapticManager.shared.medium()
        
        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
            appState.addMemory(trimmed)
        }
        
        inputText = ""
    }
}

struct Scene3Memory_Previews: PreviewProvider {
    static var previews: some View {
        Scene3Memory()
            .environment(AppState())
    }
}
