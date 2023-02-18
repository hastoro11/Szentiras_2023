//
//  ChapterViewModel.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 17..
//

import SwiftUI
import LoggerKit

class ChapterViewModel: ObservableObject {
    @Published var chapter: Chapter = .default
    @Published var isError: Bool = false
    @Published var error: APIError?
    @Published var isLoading: Bool = false
    
    var service: NetworkService = NetworkService()
    
    @MainActor
    func fetchChapter(translation: Translation, book: Book, chapter: Int) async {
        self.isLoading = true
        defer { self.isLoading = false }
        Logger.info(translation)
        Logger.info(book)
        Logger.info(chapter)
        do {
            let response = try await service.fetchChapter(translation: translation, book: book, chapter: chapter)
            self.chapter = response.chapter
        } catch {
            if let apiError = error as? APIError {
                self.error = apiError
            } else {
                self.error = APIError(statusCode: 0)
            }
            isError = true            
        }
    }
    
}
