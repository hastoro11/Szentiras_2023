//
//  TranslationList.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import SwiftUI

struct TranslationList: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Fordítások")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Mégsem")
                        .foregroundColor(.darkGreen)
                        .font(.headline)
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .background {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.top)
            }
            
            List(Translation.allCases) { translation in
                HStack {
                    ButtonText(translation.rawValue, selected: translation == appState.translation)
                    Text(translation.name)
                        .foregroundColor(translation == appState.translation ? .primary : Color(.systemGray2))
                }
                .containerShape(Rectangle())
                .onTapGesture {
                    appState.translation = translation
                    dismiss()
                }
            }
            .listStyle(.plain)
        }
    }
}

struct TranslationList_Previews: PreviewProvider {
    static var previews: some View {
        TranslationList()
            .environmentObject(AppState())
    }
}
