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
    
    private var service: NetworkServicable
    
    init(service: NetworkServicable = NetworkService()) {
        self.service = service
    }
    
    @MainActor
    func fetchChapter(translation: Translation, book: Book, chapter: Int) async {
        
        self.isLoading = true
        defer { self.isLoading = false }
        var response = SZIResponse.default
        do {
            if case Translation.KG = translation, book.number == "124" {
                response = try Util.getSZIResponse(filename: "Énekek\(chapter)")
                response.chapter.book = book
                self.chapter = response.chapter
            } else if book.number == "121" {
                response = try fetchPsalms(for: translation, and: chapter)
                self.chapter = response.chapter
            } else {
                response = try await service.fetchChapter(translation: translation, book: book, chapter: chapter)
                self.chapter = response.chapter
            }            
        } catch {
            if let apiError = error as? APIError {
                self.error = apiError
            } else {
                self.error = APIError(statusCode: 0)
            }
            isError = true
        }
    }
    
    private func fetchPsalms(for translation: Translation, and chapter: Int) throws -> SZIResponse {
        let filename = "\(translation.rawValue)_Zsolt_\(chapter)"
        let response = try Util.getSZIResponse(filename: filename)
        return response
    }
    
    @MainActor
    func fetchChapter(details: String) async {
        self.isLoading = true
        defer { self.isLoading = false }
        do {
            let response = try await service.fetchChapter(details: details)
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
