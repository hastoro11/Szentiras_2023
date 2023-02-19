//
//  Szentiras_App.swift
//  Szentiras
//
//  Created by Gabor Sornyei on 2023. 02. 16..
//

import SwiftUI
import LoggerKit

@main
struct Szentiras_App: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var appState: AppState = AppState()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .onChange(of: scenePhase) { scene in
            switch scene {
            case .background:
                if appState.shouldSaveLast {
                    Logger.info("saving")
                    Logger.verbose(appState.translation.rawValue, appState.book.abbrev, appState.chapter)
                    UserDefaults.standard.saveTranslation(appState.translation)
                    UserDefaults.standard.saveBook(appState.book)
                    UserDefaults.standard.saveChapter(appState.chapter)
                    
                }
            default:
                break
            }
        }
    }
}
