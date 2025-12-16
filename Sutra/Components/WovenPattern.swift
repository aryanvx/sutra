//
//  WovenPattern.swift
//  Sutra
//
//  Final woven pattern visualization
//
//  Created by Aryan Vyahalkar on 12/16/25.
//

import SwiftUI

struct WovenPattern: View {
    @State private var animationProgress: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Canvas { context, size in
                drawHorizontalThreads(context: context, size: size)
                drawVerticalThreads(context: context, size: size)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0)) {
                animationProgress = 1.0
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func drawHorizontalThreads(context: GraphicsContext, size: CGSize) {
        let width = size.width
        let height = size.height
        let spacing: CGFloat = 40
        
        for i in stride(from: CGFloat(0), to: height, by: spacing) {
            let path = createWavePath(
                start: CGPoint(x: 0, y: i),
                length: width,
                isHorizontal: true,
                offset: i
            )
            
            let gradient = Gradient(colors: [.saffron, .gold, .coral])
            
            context.stroke(
                path,
                with: .linearGradient(
                    gradient,
                    startPoint: .zero,
                    endPoint: CGPoint(x: width, y: 0)
                ),
                lineWidth: 2
            )
        }
    }
    
    private func drawVerticalThreads(context: GraphicsContext, size: CGSize) {
        let width = size.width
        let height = size.height
        let spacing: CGFloat = 40
        
        for i in stride(from: CGFloat(0), to: width, by: spacing) {
            let path = createWavePath(
                start: CGPoint(x: i, y: 0),
                length: height,
                isHorizontal: false,
                offset: i
            )
            
            let gradient = Gradient(colors: [.indigo, .coral, .gold])
            
            context.stroke(
                path,
                with: .linearGradient(
                    gradient,
                    startPoint: .zero,
                    endPoint: CGPoint(x: 0, y: height)
                ),
                lineWidth: 2
            )
        }
    }
    
    private func createWavePath(start: CGPoint, length: CGFloat, isHorizontal: Bool, offset: CGFloat) -> Path {
        var path = Path()
        path.move(to: start)
        
        for step in stride(from: CGFloat(0), to: length, by: 10) {
            let progress = (step / length) * animationProgress
            let waveAmount = sin((step / length) * .pi * 4 + offset / 20) * 15 * progress
            
            if isHorizontal {
                path.addLine(to: CGPoint(x: step, y: start.y + waveAmount))
            } else {
                path.addLine(to: CGPoint(x: start.x + waveAmount, y: step))
            }
        }
        
        return path
    }
}

#Preview {
    ZStack {
        Color.backgroundGradient
            .ignoresSafeArea()
        
        WovenPattern()
            .frame(height: 300)
            .padding()
    }
}
