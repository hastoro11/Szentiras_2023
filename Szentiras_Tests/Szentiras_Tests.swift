//
//  Szentiras_Tests.swift
//  Szentiras_Tests
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import XCTest
import LoggerKit


final class Szentiras_Tests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForAPI() async throws {
        let service = NetworkService()
        
        var tr = Translation.RUF
        var book = tr.books[0]
        var ch = 1
        var response: SZIResponse = try await service.fetchChapter(translation: tr, book: book, chapter: ch)
        XCTAssertEqual(response.chapter.verses.count, 31)
        
        tr = .KG
        book = Book.default
        ch = 1
        
        do {
            response = try await service.fetchChapter(translation: tr, book: book, chapter: ch)
            XCTFail("It's supposed to fail")
        } catch {
            XCTAssertNotNil(error)
        }
        
        tr = .KNB
        book = tr.books[0]
        ch = 345
        
        response = try await service.fetchChapter(translation: tr, book: book, chapter: ch)
        Logger.info(response)
        XCTAssertEqual(response.chapter.verses.count, 0)
        
        let n = 345
        XCTAssertFalse(tr.books.indices.contains(n), "Index out of bound")
        
    }
    
    func testForSuccess() async throws {
        let details = [("Mk1/KG", 45), ("1Móz1", 31)]
        
        for index in (0..<details.count) {
            let response: SZIResponse = try await NetworkKit.shared.requestCodable(API.chapter(details[index].0))
            XCTAssertEqual(response.chapter.verses.count, details[index].1)
        }
        
    }
    
    func testForEmptyVerses() async throws {
        var details = "Mk22234/KG"
        var response: SZIResponse = try await NetworkKit.shared.requestCodable(API.chapter(details))
        XCTAssertEqual(response.chapter.verses.count, 0)
        details = "rt"
        response = try await NetworkKit.shared.requestCodable(API.chapter(details))
        XCTAssertEqual(response.chapter.verses.count, 0)
    }
    
    func testForFail() async {
        do {
            let details = "/"
            let _: SZIResponse = try await NetworkKit.shared.requestCodable(API.chapter(details))
            
            XCTFail("It's supposed to fail")
        } catch {
            Logger.info(error)
            XCTAssertNotNil(error)
            if let apiError = error as? APIError {
                XCTAssertEqual(apiError.statusCode, 500)
            }
        }
    }
    
    func testUtil() {
        let search = try! Util.getSZISearch(filename: "result_sample")
        XCTAssertNotNil(search.fullTextResult)
        XCTAssertEqual(search.fullTextResult!.hitCount, 178)
        let verses = search.fullTextResult!.verses.filter({!$0.text.isEmpty})
        XCTAssertEqual(verses.count, 213)
    }
    
    func testSearchForSuccess() async throws {
        let phrase = "öszvér"
        let search: SZISearch = try await NetworkKit.shared.requestCodable(API.search(phrase))
        XCTAssertNotNil(search.fullTextResult)
        let _ = try XCTUnwrap(search.fullTextResult)
        XCTAssertEqual(search.fullTextResult!.results[0].book.number, 110)
        XCTAssertEqual(search.fullTextResult!.hitCount, 71)
        
    }
    
    func testSearchForNoHit() async throws {
        let phrase = "élkélkélk"
        let search: SZISearch = try await NetworkKit.shared.requestCodable(API.search(phrase))
        XCTAssertNil(search.fullTextResult)
    }
    
    func testSearchForFail() async {
        let phrase = "//"
        
        do {
            let _: SZISearch = try await NetworkKit.shared.requestCodable(API.search(phrase))
            XCTFail("It's supposed to fail")
        } catch {
            Logger.info(error)
            XCTAssertNotNil(error)
        }
    }
}
