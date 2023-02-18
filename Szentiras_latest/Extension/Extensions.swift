//
//  Extensions.swift
//  Szentiras_v4
//
//  Created by Gabor Sornyei on 2023. 01. 01..
//

import SwiftUI

enum UserDefaultsKeys: String {
    case translation = "translation"
    case book = "book"
    case currentChapter = "currentChapter"
}

extension Color {
    static var darkGreen: Color {
        Color("darkGreen")
    }
    
    static var bgGray: Color {
        Color("bgGray")
    }

    static var textGray: Color {
        Color("textGray")
    }
}

extension UserDefaults {
    
    func saveCurrentChapter(_ chapter: String) {
        UserDefaults.standard.set(chapter, forKey: UserDefaultsKeys.currentChapter.rawValue)
    }
    
    func loadCurrentChapter() -> Int {
        UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentChapter.rawValue) == 0 ? 1 : UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentChapter.rawValue)
    }
}

extension String {
    var html: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}


extension View {
    func showError(isPresented: Binding<Bool>, error: APIError?, guidance: String) -> some View {
        Group {
            if let error = error {
                ZStack {
                    self.redacted(reason: isPresented.wrappedValue ? .placeholder : [])
                    ErrorAlertView(errorWrapper: ErrorWrapper(error: error, guidance: guidance))
                }
            } else {
                self
            }
        }
    }
    
    func isLoading(_ loading: Binding<Bool>) -> some View {
        Group {
            if loading.wrappedValue {
                ZStack {
                    self
                        .redacted(reason: loading.wrappedValue ? .placeholder : [])
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Material.thick)
                        .frame(width: 100, height: 100)
                    ProgressView {
                        Text("Keresés...")
                    }
                }
            } else {
                self
            }
        }
    }
}
