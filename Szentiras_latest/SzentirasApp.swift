//
//  Szentiras_App.swift
//  Szentiras
//
//  Created by Gabor Sornyei on 2023. 02. 16..
//

import SwiftUI

@main
struct Szentiras_App: App {
    @StateObject var appState: AppState = AppState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
