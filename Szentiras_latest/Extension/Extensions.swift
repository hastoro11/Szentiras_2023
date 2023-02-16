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
