//
//  ContentView.swift
//  Sutra
//
//  Created by Aryan Vyahalkar on 12/15/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        ZStack {
            switch appState.currentScene {
            case 1:
                Scene1Place()
            case 2:
                Scene2Language()
            case 3:
                Scene3Memory()
            case 4:
                SceneEnding()
            default:
                Scene1Place()
            }
        }
        .animation(.easeInOut(duration: 0.8), value: appState.currentScene)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(AppState())
    }
}
