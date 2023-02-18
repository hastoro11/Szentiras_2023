//
//  NetworkService.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import Foundation
import LoggerKit

protocol NetworkServicable {
    func fetchChapter(translation: Translation, book: Book, chapter: Int) async throws -> SZIResponse
}

class NetworkService: NetworkServicable {
    func fetchChapter(translation: Translation, book: Book, chapter: Int) async throws -> SZIResponse {
        let details = "\(book.abbrev)\(chapter)/\(translation.rawValue)"
        let response: SZIResponse = try await NetworkKit.shared.requestCodable(API.chapter(details))
        if response.chapter.verses.isEmpty {
            throw APIError(statusCode: 0)
        }
        return response
    }
}
