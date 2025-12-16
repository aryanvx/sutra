//
//  MemoryCircle.swift
//  Sutra
//
//  Component for circular memory thread visualization
//
//  Created by Aryan Vyahalkar on 11/11/25.
//

import SwiftUI

struct MemoryCircle: View {
    let threads: [MemoryThread]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Center dot
                Circle()
                    .fill(Color.threadGradient)
                    .frame(width: 12, height: 12)
                
                // Memory threads radiating outward
                ForEach(threads) { thread in
                    MemoryThreadView(thread: thread, radius: min(geometry.size.width, geometry.size.height) / 2 - 50)
                }
                
                // Connecting web lines
                if threads.count > 1 {
                    Path { path in
                        for i in 0..<threads.count {
                            let angle1 = threads[i].angle * .pi / 180
                            let radius = min(geometry.size.width, geometry.size.height) / 2 - 70
                            let x1 = cos(angle1) * radius
                            let y1 = sin(angle1) * radius
                            
                            if i == 0 {
                                path.move(to: CGPoint(x: x1, y: y1))
                            } else {
                                path.addLine(to: CGPoint(x: x1, y: y1))
                            }
                        }
                        
                        // Close the path if 3+ threads
                        if threads.count >= 3 {
                            path.closeSubpath()
                        }
                    }
                    .stroke(Color.threadGradient.opacity(0.3), lineWidth: 1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Individual Memory Thread
struct MemoryThreadView: View {
    let thread: MemoryThread
    let radius: CGFloat
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            let angle = thread.angle * .pi / 180
            let x = cos(angle) * radius
            let y = sin(angle) * radius
            
            VStack(spacing: 8) {
                // Thread line from center
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: x, y: y))
                }
                .stroke(Color.threadGradient, lineWidth: 2)
                
                // Memory text
                Text(thread.text)
                    .font(.memoryText)
                    .foregroundStyle(Color.threadGradient)
                    .padding(12)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(8)
                    .shadow(color: Color.saffron.opacity(0.3), radius: 10)
                    .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                    .scaleEffect(scale)
                    .opacity(opacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundGradient
            .ignoresSafeArea()
        
        MemoryCircle(threads: [
            MemoryThread(text: "Family", angle: 0),
            MemoryThread(text: "Friends", angle: 90),
            MemoryThread(text: "Food", angle: 180),
            MemoryThread(text: "Music", angle: 270)
        ])
        .frame(height: 400)
        .padding()
    }
}
