//
//  ContentView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 16..
//

import SwiftUI
import LoggerKit

struct ContentView: View {
    @State var showLaunchScreen: Bool = true
    @State var remainingTime = 2.5
    
    var timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    var body: some View {
        ZStack {
            TabView {                
                BookList()                    
                    .tabItem {
                        Label("Biblia", systemImage: "book")
                    }
                SearchView()
                    .tabItem {
                        Label("Keresés", systemImage: "magnifyingglass")
                    }
                SettingView()
                    .tabItem {
                        Label("Beállítások", systemImage: "gear")
                    }
            }
            .tint(.darkGreen)
            
            if showLaunchScreen {
                LaunchScreen()
                    .zIndex(1)
                    .transition(.asymmetric(insertion: .identity, removal: .opacity))
            }
        }
        .onReceive(timer) { t in
            remainingTime -= 1
            if remainingTime <= 0 {
                timer.upstream.connect().cancel()
                withAnimation(.default) {
                    showLaunchScreen = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
