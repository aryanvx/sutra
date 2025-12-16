//
//  Colors.swift
//  Sutra
//
//  Color palette for the app
//
//  Created by Aryan Vyahalkar on 12/12/25.
//

import SwiftUI

extension Color {
    static let saffron = Color(red: 1.0, green: 0.6, blue: 0.2)
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let coral = Color(red: 1.0, green: 0.42, blue: 0.42)
    static let indigo = Color(red: 0.39, green: 0.4, blue: 0.95)
    
    static let ivoryLight = Color(red: 0.96, green: 0.95, blue: 0.91)
    static let ivoryBase = Color(red: 0.98, green: 0.97, blue: 0.94)
    
    static let subtleGray = Color(red: 0.5, green: 0.5, blue: 0.5)
    
    static let threadGradient = LinearGradient(
        colors: [.saffron, .gold, .coral],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let backgroundGradient = LinearGradient(
        colors: [.ivoryLight, .ivoryBase],
        startPoint: .top,
        endPoint: .bottom
    )
}
