//
//  SZISearch.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 22..
//

import Foundation

// MARK: - SZISearch
struct SZISearch: Codable {
    let fullTextResult: FullTextResult
}

// MARK: - FullTextResult
struct FullTextResult: Codable {
    let results: [Result]
    let hitCount: Int
}

extension FullTextResult {
    static var `default`: FullTextResult {
        FullTextResult(results: [], hitCount: 0)
    }
}

extension FullTextResult {    
    var verses: [Vers] {
        var verses = [Vers]()
        for result in results {
            let vers = result.verses.map { vers -> Vers in
                Vers(
                    bookNumber: String(result.book.number),
                    bookAbbrev: String(result.book.abbrev),
                    translationID: result.book.translationID,
                    translationAbbrev: result.translation.abbrev.rawValue,
                    chapter: vers.chapter,
                    numv: Int(vers.numv) ?? 0,
                    text: vers.text)
            }
            verses += vers
        }
        return verses.filter({!$0.text.isEmpty})
    }
    
    struct Vers: Codable, Identifiable {
        var id: String {
            "\(bookNumber)/\(chapter)/\(numv)/\(translationID)"
        }
        var bookNumber: String
        var bookAbbrev: String
        var translationID: Int
        var translationAbbrev: String
        var chapter: Int
        var numv: Int
        var text: String
        
        var abbrev: String {
            "\(bookNumber)/\(chapter)/\(numv)/\(translationID)"
        }
        
        static var `default`: Vers {
            Vers(bookNumber: "101", bookAbbrev: "1Móz", translationID: 6, translationAbbrev: "RUF", chapter: 1, numv: 1, text: "")
        }
    }
}

// MARK: - Result
struct Result: Codable, Identifiable {
    var id = UUID().uuidString
    let book: SZIBook
    let translation: SZITranslation
    let chapters: [String: [SZIVers]]
    let verses: [SZIVers]
    
    enum CodingKeys: String, CodingKey {
        case book, translation, chapters, verses
    }
    
    
}

// MARK: - Book
struct SZIBook: Codable, Equatable {
    let number: Int
    let translationID: Int
    let name, abbrev, link: String
    let oldTestament, id: Int

    enum CodingKeys: String, CodingKey {
        case number
        case translationID = "translation_id"
        case name, abbrev, link
        case oldTestament = "old_testament"
        case id
    }
}

// MARK: - Verse
struct SZIVers: Codable {
    let chapter: Int
    let numv, text: String
}

// MARK: - Translation
struct SZITranslation: Codable {
    let id: Int
    let name: Name
    let abbrev: Abbrev
    let order: Int
    let denom: Denom
    let lang: Lang
    let copyright: String
    let publisher: Publisher
    let publisherURL: String
    let reference: String

    enum CodingKeys: String, CodingKey {
        case id
        case name, abbrev, order, denom, lang, copyright, publisher
        case publisherURL = "publisher_url"
        case reference
    }
}

enum Abbrev: String, Codable {
    case bd = "BD"
    case kg = "KG"
    case knb = "KNB"
    case ruf = "RUF"
    case stl = "STL"
    case szit = "SZIT"
    case uf = "UF"
}

enum Denom: String, Codable {
    case katolikus = "katolikus"
    case protestáns = "protestáns"
}

enum Lang: String, Codable {
    case magyar = "magyar"
}

enum Name: String, Codable {
    case békésDalosÚjszövetségiSzentírás = "Békés-Dalos Újszövetségi Szentírás"
    case káldiNeovulgáta = "Káldi-Neovulgáta"
    case károliGáspárRevideáltFordítása = "Károli Gáspár revideált fordítása"
    case magyarBibliatársulatÚjfordításúBibliája1990 = "Magyar Bibliatársulat újfordítású Bibliája (1990)"
    case magyarBibliatársulatÚjfordításúBibliája2014 = "Magyar Bibliatársulat újfordítású Bibliája (2014)"
    case simonTamásLászlóÚjszövetségFordítása = "Simon Tamás László Újszövetség-fordítása"
    case szentIstvánTársulatiBiblia = "Szent István Társulati Biblia"
}

enum Publisher: String, Codable {
    case bencésKiadó = "Bencés Kiadó"
    case katolikusBibliatársulat = "Katolikus Bibliatársulat"
    case magyarBibliatársulat = "Magyar Bibliatársulat"
    case szentIstvánTársulat = "Szent István Társulat"
    case theWord = "The Word"
}
