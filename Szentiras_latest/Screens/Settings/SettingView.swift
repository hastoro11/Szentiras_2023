//
//  SettingView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 19..
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var appState: AppState
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HStack {
                    Text("Beállítások")
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .padding()
            .background {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.top)
            }
            Form {
                Section {
                    Toggle("Jelenlegi hely mentése", isOn: $appState.shouldSaveLast)
                } header: {
                    Text("Biblia")
                }
                Section {
                    Link("Adavédelmi politika", destination: URL(string: "https://sornyei.hu/szentiras/")!)
                }
                .tint(.darkGreen)
            }            
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(AppState())
    }
}
