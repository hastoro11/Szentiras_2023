//
//  MockService.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import Foundation

class MockService: NetworkServicable {
    
    var stub: () async throws -> SZIResponse
    
    init(stub: @escaping () async throws -> SZIResponse) {
        self.stub = stub
    }
    
    func fetchChapter(translation: Translation, book: Book, chapter: Int) async throws -> SZIResponse {
        try await stub()
    }
}
