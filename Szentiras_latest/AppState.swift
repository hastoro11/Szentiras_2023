//
//  AppState.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import SwiftUI

class AppState: ObservableObject {
    @Published var shouldSaveLast: Bool {
        didSet {
            UserDefaults.standard.saveShouldSaveLAst(shouldSaveLast)
        }
    }
    @Published var translation: Translation
    @Published var book: Book
    @Published var chapter: Int
    
    
    init() {
        let shouldSaveLast = UserDefaults.standard.loadShouldSaveLast()
        self.shouldSaveLast = shouldSaveLast
        if shouldSaveLast {
            self.translation = UserDefaults.standard.loadTranslation()
            self.book = UserDefaults.standard.loadBook()
            self.chapter = UserDefaults.standard.loadChapter()
        } else {
            self.translation = .RUF
            self.book = Book.default
            self.chapter = 0
        }
    }   
}
