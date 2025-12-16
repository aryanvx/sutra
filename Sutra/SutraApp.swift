//
//  SutraApp.swift
//  Sutra
//
//  Created by Aryan Vyahalkar on 11/10/25.
//

import SwiftUI

@main
struct SutraApp: App {
    @State private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appState)
        }
    }
}
