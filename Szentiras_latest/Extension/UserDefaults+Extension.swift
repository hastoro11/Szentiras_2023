//
//  UserDefaults+Extension.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 19..
//

import Foundation

enum UserDefaultsKeys: String {
    case saveLast = "saveLast"
    case translation = "translation"
    case book = "book"
    case currentChapter = "currentChapter"
}

extension UserDefaults {
    
    func saveShouldSaveLAst(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.saveLast.rawValue)
    }
    
    func saveTranslation(_ translation: Translation) {
        UserDefaults.standard.set(translation.rawValue, forKey: UserDefaultsKeys.translation.rawValue)
    }
    
    func saveBook(_ book: Book) {
        UserDefaults.standard.set(book.number, forKey: UserDefaultsKeys.book.rawValue)
    }
    
    func saveChapter(_ chapter: Int) {
        UserDefaults.standard.set(chapter, forKey: UserDefaultsKeys.currentChapter.rawValue)
    }
    
    func loadShouldSaveLast() -> Bool {
        UserDefaults.standard.bool(forKey: UserDefaultsKeys.saveLast.rawValue)
    }
    
    func loadTranslation() -> Translation {
        let translationAbbrev = UserDefaults.standard.string(forKey: UserDefaultsKeys.translation.rawValue)
        if let abbrev = translationAbbrev, let translation = Translation(rawValue: abbrev) {
            return translation
        }
        
        return .RUF
    }
    
    func loadBook() -> Book {
        let translation = loadTranslation()
        let bookNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.book.rawValue)
        if let book = translation.books.first(where: { $0.number == bookNumber}) {
            return book
        }
        
        return Book.default
    }
    
    func loadChapter() -> Int {
        UserDefaults.standard.integer(forKey: UserDefaultsKeys.currentChapter.rawValue)
    }
}
