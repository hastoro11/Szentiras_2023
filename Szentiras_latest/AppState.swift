//
//  AppState.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import SwiftUI

class AppState: ObservableObject {
    @Published var translation: Translation = .RUF
    @Published var book: Book = Book.default
    @Published var chapter: Int = 0
   
}
