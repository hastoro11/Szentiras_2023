//
//  MockService.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import Foundation

class MockService: NetworkServicable {
    
    var stub: () async throws -> SZIResponse
    var searchStub: () async throws -> SZISearch
    
    init(
stub: @escaping () async throws -> SZIResponse = {  return SZIResponse.default},
searchStub: @escaping () async throws -> SZISearch = { return SZISearch.default}) {
        self.stub = stub
        self.searchStub = searchStub
    }
    
    func fetchChapter(translation: Translation, book: Book, chapter: Int) async throws -> SZIResponse {
        try await stub()
    }
    
    func fetchChapter(details: String) async throws -> SZIResponse {
        try await stub()
    }
    
    func fetchSearch(search: String) async throws -> SZISearch {
        try await searchStub()
    }
}
