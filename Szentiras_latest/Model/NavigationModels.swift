//
//  NavigationModels.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import Foundation

struct TranslationBook: Hashable {
    var translation: Translation
    var book: Book
    
    init(translation: Translation, book: Book) {
        self.translation = translation
        self.book = book
    }
}

struct TranslationBookChapter: Hashable {
    var translation: Translation
    var book: Book
    var chapter: Int
    
    init(translation: Translation, book: Book, chapter: Int) {
        self.translation = translation
        self.book = book
        self.chapter = chapter
    }
}
