//
//  SZIResponse.swift
//  Szentiras_v3
//
//  Created by Gabor Sornyei on 2022. 11. 12..
//!


import Foundation

// MARK: - SZIResponse
struct SZIResponse: Decodable {
    let keres: Keres
    let chapter: Chapter
    
    enum CodingKeys: String, CodingKey {
        case keres
        case chapter = "valasz"
    }
}

extension SZIResponse {
    static var `default`: SZIResponse {
        SZIResponse(
            keres: Keres(feladat: "", hivatkozas: "", forma: ""),
            chapter: Chapter(verses: [], book: Book.default, current: 0, translationAbbrev: "", translationName: ""))
    }
}

// MARK: - Keres
struct Keres: Codable {
    let feladat, hivatkozas, forma: String
}

// MARK: - Chapter
struct Chapter: Decodable {
    let verses: [Vers]
    let book: Book
    let current: Int
    let translationAbbrev: String
    let translationName: String
    
    enum CodingKeys: String, CodingKey {
        case verses = "versek"
        case translation = "forditas"
    }
    
    enum TranslationCondingKeys: String, CodingKey {
        case name = "nev"
        case abbrev = "rov"
    }
    
    init(verses: [Vers], book: Book, current: Int, translationAbbrev: String, translationName: String) {
        self.verses = verses
        self.book = book
        self.current = current
        self.translationAbbrev = translationAbbrev
        self.translationName = translationName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let translationContainer = try container.nestedContainer(keyedBy: TranslationCondingKeys.self, forKey: .translation)
        let abbrev = (try? translationContainer.decode(String.self, forKey: .abbrev)) ?? ""
        self.translationAbbrev = abbrev
        let name = (try? translationContainer.decode(String.self, forKey: .name)) ?? ""
        self.translationName = name
        let verses = (try? container.decode([Vers].self, forKey: .verses)) ?? []
        self.verses = verses.map { vers in
            var newVers = vers
            
            let refArray = vers.ref.split(separator: " ")
            let codeArray = String(refArray[1]).split(separator: ",")
            
            let translation = Translation(rawValue: abbrev)
            let books = translation?.books
            let book = books?.first { $0.abbrev ==  String(refArray[0])}
            
            newVers.bookID = book?.number ?? ""
            newVers.bookAbbrev = String(refArray[0])
            newVers.chapter = Int(String(codeArray[0])) ?? 0
            newVers.versIndex = Int(String(codeArray[1])) ?? 0
            newVers.translationName = name
            newVers.translationAbbrev = abbrev
            return newVers
        }
        
        if let firstVers = self.verses.first,
           let books = Translation(rawValue: abbrev)?.books,
           let book = books.first(where: {$0.id == firstVers.bookID}){
            self.book = book
            self.current = firstVers.chapter
        } else {
            self.book = Book.default
            self.current = 1
        }
    }
}

extension Chapter {
    static var `default`: Chapter {
        Chapter(verses: [], book: Book.default, current: 0, translationAbbrev: "", translationName: "")
    }
}

// MARK: - Versek
struct Vers: Decodable, Identifiable {
    let text: String
    let id: String
    let ref: String
    var translationAbbrev: String = ""
    var translationName: String = ""
    
    var bookID: String = ""
    var bookAbbrev: String = ""
    var chapter: Int = 0
    var versIndex: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case text = "szoveg"
        case address = "hely"
    }
    
    enum AddressKeys: String, CodingKey {
        case id = "gepi"
        case ref = "szep"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = (try? container.decode(String.self, forKey: .text)) ?? ""
        let addressContainer = try container.nestedContainer(keyedBy: AddressKeys.self, forKey: .address)
        let id = (try? addressContainer.decode(Int.self, forKey: .id) ) ?? 0
        self.id = String(id)
        self.ref = (try? addressContainer.decode(String.self, forKey: .ref)) ?? ""
    }
}

//extension Vers {
//    var bookID: String {
//        let translation = Translation(rawValue: self.translationAbbrev)
//        let books = translation?.books
//        let book = books?.first { $0.abbrev == bookAbbrev}
//        return book?.id ?? "n/a"
//    }
//    var bookAbbrev: String {
//        let refArray = ref.split(separator: " ")
//        return String(refArray[0])
//    }
//    
//    var chapter: Int {
//        let refArray = ref.split(separator: " ")
//        let codeArray = String(refArray[1]).split(separator: ",")
//        return Int(String(codeArray[0])) ?? 0
//    }
//    
//    var versIndex: Int {
//        let refArray = ref.split(separator: " ")
//        let codeArray = String(refArray[1]).split(separator: ",")
//        return Int(String(codeArray[1])) ?? 0
//    }
//}
