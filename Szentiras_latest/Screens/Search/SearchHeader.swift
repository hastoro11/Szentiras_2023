//
//  SearchHeader.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 25..
//

import SwiftUI

struct SearchHeader: View {
    @Environment(\.dismiss) var dismiss
    var text: String
    var showButton: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text(text)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                if showButton {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Vissza")
                            .foregroundColor(.darkGreen)
                            .font(.headline)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding()
        .background {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.top)
        }
    }
}

struct SearchHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchHeader(text: "Keresés", showButton: true)
            SearchHeader(text: "Keresés", showButton: false)
        }
    }
}
