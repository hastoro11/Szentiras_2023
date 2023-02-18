//
//  NetworkService.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import Foundation
import LoggerKit

class NetworkService {
    func fetchChapter(translation: Translation, book: Book, chapter: Int) async throws -> SZIResponse {
        let details = "\(book.abbrev)\(chapter)/\(translation.rawValue)"        
        return try await NetworkKit.shared.requestCodable(API.chapter(details))
    }
}
