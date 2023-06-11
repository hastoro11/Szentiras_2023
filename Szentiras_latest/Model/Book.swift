//
//  Books.swift
//  Szentiras15v2
//
//  Created by Gabor Sornyei on 2022. 06. 11..
//

import Foundation

enum Translation: String, CaseIterable, Identifiable {
    var id: String {
        name
    }
    
    case SZIT = "SZIT"
    case UF = "UF"
    case KNB = "KNB"
    case KG = "KG"
    case RUF = "RUF"
    
    var name: String {
        switch self {
        case .SZIT:
            return "Szent István Társulati Biblia"
        case .UF:
            return "Magyar Bibliatársulat újfordítású Bibliája (1990)"
        case .KNB:
            return "Káldi-Neovulgáta"
        case .KG:
            return "Károli Gáspár revideált fordítása"
        case .RUF:
            return "Magyar Bibliatársulat újfordítású Bibliája (2014)"
        }
    }
    
    var denom: String {
        switch self {
        case .SZIT, .KNB:
            return "katolikus"
        default:
            return "protestáns"
        }
    }
    
    var books: [Book] {
        switch self {
        case .SZIT:
            return Book.SZIT
        case .UF:
            return Book.UF
        case .KNB:
            return Book.KNB
        case .KG:
            return Book.KG
        case .RUF:
            return Book.RUF
        }
    }
}

extension Translation {
    func save() {
        UserDefaults.standard.set(self.rawValue, forKey: UserDefaultsKeys.translation.rawValue)
    }
    
    static func load() -> Translation {
        let abbrev = UserDefaults.standard.string(forKey: UserDefaultsKeys.translation.rawValue) ?? "RUF"
        return Translation(rawValue: abbrev) ?? .RUF
    }
    
    static func load(by id: String) -> Translation? {
        return Translation(rawValue: id) ?? nil
    }
}

struct Book: Codable, Identifiable, Hashable {
    var id: String { number }
    var number: String
    var name: String
    var abbrev: String
    var noOfChapters: Int
}

extension Book {
    
    static func getBookInCombined(by number: String) -> Book {
        return combined.first { $0.number == number } ?? combined[0]
    }
    
    static var combined: [Book] {
        [
            Book(
                number: "101",
                name: "Mózes első könyve",
                abbrev: "1Móz",
                noOfChapters: 50),
            Book(
                number: "102",
                name: "Mózes második könyve",
                abbrev: "2Móz",
                noOfChapters: 40),
            Book(
                number: "103",
                name: "Mózes harmadik könyve",
                abbrev: "3Móz",
                noOfChapters: 27),
            Book(
                number: "104",
                name: "Mózes negyedik könyve",
                abbrev: "4Móz",
                noOfChapters: 36),
            Book(
                number: "105",
                name: "Mózes ötödik könyve",
                abbrev: "5Móz",
                noOfChapters: 34),
            Book(
                number: "106",
                name: "Józsué könyve",
                abbrev: "Józs",
                noOfChapters: 24),
            Book(
                number: "107",
                name: "A bírák könyve",
                abbrev: "Bír",
                noOfChapters: 21),
            Book(
                number: "108",
                name: "Ruth könyve",
                abbrev: "Ruth",
                noOfChapters: 4),
            Book(
                number: "109",
                name: "Sámuel első könyve",
                abbrev: "1Sám",
                noOfChapters: 31),
            Book(
                number: "110",
                name: "Sámuel második könyve",
                abbrev: "2Sám",
                noOfChapters: 24),
            Book(
                number: "111",
                name: "A királyok első könyve",
                abbrev: "1Kir",
                noOfChapters: 22),
            Book(
                number: "112",
                name: "A királyok második könyve",
                abbrev: "2Kir",
                noOfChapters: 25),
            Book(
                number: "113",
                name: "A krónikák első könyve",
                abbrev: "1Krón",
                noOfChapters: 29),
            Book(
                number: "114",
                name: "A krónikák második könyve",
                abbrev: "2Krón",
                noOfChapters: 36),
            Book(
                number: "115",
                name: "Ezsdrás könyve",
                abbrev: "Ezsd",
                noOfChapters: 10),
            Book(
                number: "116",
                name: "Nehemiás könyve",
                abbrev: "Neh",
                noOfChapters: 13),
            Book(
                number: "117",
                name: "Tóbiás könyve",
                abbrev: "Tób",
                noOfChapters: 14),
            Book(
                number: "118",
                name: "Judit könyve",
                abbrev: "Jud",
                noOfChapters: 16),
            Book(
                number: "119",
                name: "Eszter könyve",
                abbrev: "Eszt",
                noOfChapters: 10),
            Book(
                number: "120",
                name: "Jób könyve",
                abbrev: "Jób",
                noOfChapters: 42),
            Book(
                number: "121",
                name: "A zsoltárok könyve",
                abbrev: "Zsolt",
                noOfChapters: 150),
            Book(
                number: "122",
                name: "A példabeszédek könyve",
                abbrev: "Péld",
                noOfChapters: 31),
            Book(
                number: "123",
                name: "A prédikátor könyve",
                abbrev: "Préd",
                noOfChapters: 12),
            Book(
                number: "124",
                name: "Énekek éneke",
                abbrev: "Énekek",
                noOfChapters: 8),
            Book(
                number: "125",
                name: "Bölcsesség könyve",
                abbrev: "Bölcs",
                noOfChapters: 19),
            Book(
                number: "126",
                name: "Sirák fia könyve",
                abbrev: "Sir",
                noOfChapters: 51),
            Book(
                number: "127",
                name: "Ézsaiás próféta könyve",
                abbrev: "Ézs",
                noOfChapters: 66),
            Book(
                number: "128",
                name: "Jeremiás próféta könyve",
                abbrev: "Jer",
                noOfChapters: 52),
            Book(
                number: "129",
                name: "Jeremiás siralmai",
                abbrev: "Jsir",
                noOfChapters: 5),
            Book(
                number: "130",
                name: "Báruk könyve",
                abbrev: "Bár",
                noOfChapters: 6),
            Book(
                number: "131",
                name: "Ezékiel próféta könyve",
                abbrev: "Ez",
                noOfChapters: 48),
            Book(
                number: "132",
                name: "Dániel próféta könyve",
                abbrev: "Dán",
                noOfChapters: 14),
            Book(
                number: "133",
                name: "Hóseás próféta könyve",
                abbrev: "Hós",
                noOfChapters: 14),
            Book(
                number: "134",
                name: "Jóel könyve",
                abbrev: "Jóel",
                noOfChapters: 4),
            Book(
                number: "135",
                name: "Ámosz próféta könyve",
                abbrev: "Ám",
                noOfChapters: 9),
            Book(
                number: "136",
                name: "Abdiás próféta könyve",
                abbrev: "Abd",
                noOfChapters: 1),
            Book(
                number: "137",
                name: "Jónás próféta könyve",
                abbrev: "Jón",
                noOfChapters: 4),
            Book(
                number: "138",
                name: "Mikeás próféta könyve",
                abbrev: "Mik",
                noOfChapters: 7),
            Book(
                number: "139",
                name: "Náhum próféta könyve",
                abbrev: "Náh",
                noOfChapters: 3),
            Book(
                number: "140",
                name: "Habakuk próféta könyve",
                abbrev: "Hab",
                noOfChapters: 3),
            Book(
                number: "141",
                name: "Zofóniás próféta könyve",
                abbrev: "Zof",
                noOfChapters: 3),
            Book(
                number: "142",
                name: "Haggeus próféta könyve",
                abbrev: "Hag",
                noOfChapters: 2),
            Book(
                number: "143",
                name: "Zakariás próféta könyve",
                abbrev: "Zak",
                noOfChapters: 14),
            Book(
                number: "144",
                name: "Malakiás próféta könyve",
                abbrev: "Mal",
                noOfChapters: 3),
            Book(
                number: "145",
                name: "Makkabeusok I. könyve",
                abbrev: "1Mak",
                noOfChapters: 16),
            Book(
                number: "146",
                name: "Makkabeusok II. könyve",
                abbrev: "2Mak",
                noOfChapters: 15),
            //
            //          Újszövetség
            //
            Book(
                number: "201",
                name: "Máté evangéliuma",
                abbrev: "Mt",
                noOfChapters: 28),
            Book(
                number: "202",
                name: "Márk evangéliuma",
                abbrev: "Mk",
                noOfChapters: 16),
            Book(
                number: "203",
                name: "Lukács evangéliuma",
                abbrev: "Lk",
                noOfChapters: 24),
            Book(
                number: "204",
                name: "János evangéliuma",
                abbrev: "Jn",
                noOfChapters: 21),
            Book(
                number: "205",
                name: "Az apostolok cselekedetei",
                abbrev: "ApCsel",
                noOfChapters: 28),
            Book(
                number: "206",
                name: "Pál levele a rómaiakhoz",
                abbrev: "Róm",
                noOfChapters: 16),
            Book(
                number: "207",
                name: "Pál első levele a korinthusiakhoz",
                abbrev: "1Kor",
                noOfChapters: 16),
            Book(
                number: "208",
                name: "Pál második levele a korinthusiakhoz",
                abbrev: "2Kor",
                noOfChapters: 13),
            Book(
                number: "209",
                name: "Pál levele a galatákhoz",
                abbrev: "Gal",
                noOfChapters: 6),
            Book(
                number: "210",
                name: "Pál levele az efezusiakhoz",
                abbrev: "Ef",
                noOfChapters: 6),
            Book(
                number: "211",
                name: "Pál levele a filippiekhez",
                abbrev: "Fil",
                noOfChapters: 4),
            Book(
                number: "212",
                name: "Pál levele a kolosséiakhoz",
                abbrev: "Kol",
                noOfChapters: 4),
            Book(
                number: "213",
                name: "Pál első levele a thesszalonikaiakhoz",
                abbrev: "1Thessz",
                noOfChapters: 5),
            Book(
                number: "214",
                name: "Pál második levele a thesszalonikaiakhoz",
                abbrev: "2Thessz",
                noOfChapters: 3),
            Book(
                number: "215",
                name: "Pál első levele Timóteushoz",
                abbrev: "1Tim",
                noOfChapters: 6),
            Book(
                number: "216",
                name: "Pál második levele Timóteushoz",
                abbrev: "2Tim",
                noOfChapters: 3),
            Book(
                number: "217",
                name: "Pál levele Tituszhoz",
                abbrev: "Tit",
                noOfChapters: 3),
            Book(
                number: "218",
                name: "Pál levele Filemonhoz",
                abbrev: "Filem",
                noOfChapters: 1),
            Book(
                number: "219",
                name: "A zsidókhoz írt levél",
                abbrev: "Zsid",
                noOfChapters: 13),
            Book(
                number: "220",
                name: "Jakab levele",
                abbrev: "Jak",
                noOfChapters: 5),
            Book(
                number: "221",
                name: "Péter első levele",
                abbrev: "1Pt",
                noOfChapters: 5),
            Book(
                number: "222",
                name: "Péter második levele",
                abbrev: "2Pt",
                noOfChapters: 3),
            Book(
                number: "223",
                name: "János első levele",
                abbrev: "1Jn",
                noOfChapters: 5),
            Book(
                number: "224",
                name: "János második levele",
                abbrev: "2Jn",
                noOfChapters: 1),
            Book(
                number: "225",
                name: "János harmadik levele",
                abbrev: "3Jn",
                noOfChapters: 1),
            Book(
                number: "226",
                name: "Júdás levele",
                abbrev: "Júd",
                noOfChapters: 1),
            Book(
                number: "227",
                name: "A jelenések könyve",
                abbrev: "Jel",
                noOfChapters: 22),
        ]
    }
    
    static var SZIT: [Book] {
        [
            Book(
                number: "101",
                name: "Teremtés könyve",
                abbrev: "Ter",
                noOfChapters: 50),
            Book(
                number: "102",
                name: "Kivonulás könyve",
                abbrev: "Kiv",
                noOfChapters: 40),
            Book(
                number: "103",
                name: "Leviták könyve",
                abbrev: "Lev",
                noOfChapters: 27),
            Book(
                number: "104",
                name: "Számok könyve",
                abbrev: "Szám",
                noOfChapters: 36),
            Book(
                number: "105",
                name: "Második Törvénykönyv",
                abbrev: "MTörv",
                noOfChapters: 34),
            Book(
                number: "106",
                name: "Józsué könyve",
                abbrev: "Józs",
                noOfChapters: 24),
            Book(
                number: "107",
                name: "Bírák könyve",
                abbrev: "Bír",
                noOfChapters: 21),
            Book(
                number: "108",
                name: "Rut könyve",
                abbrev: "Rut",
                noOfChapters: 4),
            Book(
                number: "109",
                name: "Sámuel I. könyve",
                abbrev: "1Sám",
                noOfChapters: 31),
            Book(
                number: "110",
                name: "Sámuel II. könyve",
                abbrev: "2Sám",
                noOfChapters: 24),
            Book(
                number: "111",
                name: "Királyok I. könyve",
                abbrev: "1Kir",
                noOfChapters: 22),
            Book(
                number: "112",
                name: "Királyok II. könyve",
                abbrev: "2Kir",
                noOfChapters: 25),
            Book(
                number: "113",
                name: "Krónikák I. könyve",
                abbrev: "1Krón",
                noOfChapters: 29),
            Book(
                number: "114",
                name: "Krónikák II. könyve",
                abbrev: "2Krón",
                noOfChapters: 36),
            Book(
                number: "115",
                name: "Ezdrás könyve",
                abbrev: "Ezd",
                noOfChapters: 10),
            Book(
                number: "116",
                name: "Nehemiás könyve",
                abbrev: "Neh",
                noOfChapters: 13),
            Book(
                number: "117",
                name: "Tóbiás könyve",
                abbrev: "Tób",
                noOfChapters: 14),
            Book(
                number: "118",
                name: "Judit könyve",
                abbrev: "Jud",
                noOfChapters: 16),
            Book(
                number: "119",
                name: "Eszter könyve",
                abbrev: "Esz",
                noOfChapters: 10),
            Book(
                number: "120",
                name: "Jób könyve",
                abbrev: "Jób",
                noOfChapters: 42),
            Book(
                number: "121",
                name: "Zsoltárok könyve",
                abbrev: "Zsolt",
                noOfChapters: 150),
            Book(
                number: "122",
                name: "Példabeszédek könyve",
                abbrev: "Péld",
                noOfChapters: 31),
            Book(
                number: "123",
                name: "Prédikátor könyve",
                abbrev: "Préd",
                noOfChapters: 12),
            Book(
                number: "124",
                name: "Énekek éneke",
                abbrev: "Én",
                noOfChapters: 8),
            Book(
                number: "125",
                name: "Bölcsesség könyve",
                abbrev: "Bölcs",
                noOfChapters: 19),
            Book(
                number: "126",
                name: "Sirák fia könyve",
                abbrev: "Sir",
                noOfChapters: 51),
            Book(
                number: "127",
                name: "Izajás könyve",
                abbrev: "Iz",
                noOfChapters: 66),
            Book(
                number: "128",
                name: "Jeremiás könyve",
                abbrev: "Jer",
                noOfChapters: 52),
            Book(
                number: "129",
                name: "Siralmak könyve",
                abbrev: "Siral",
                noOfChapters: 5),
            Book(
                number: "130",
                name: "Báruk könyve",
                abbrev: "Bár",
                noOfChapters: 6),
            Book(
                number: "131",
                name: "Ezékiel könyve",
                abbrev: "Ez",
                noOfChapters: 48),
            Book(
                number: "132",
                name: "Dániel könyve",
                abbrev: "Dán",
                noOfChapters: 14),
            Book(
                number: "133",
                name: "Ozeás könyve",
                abbrev: "Oz",
                noOfChapters: 14),
            Book(
                number: "134",
                name: "Joel könyve",
                abbrev: "Jo",
                noOfChapters: 4),
            Book(
                number: "135",
                name: "Ámosz könyve",
                abbrev: "Ám",
                noOfChapters: 9),
            Book(
                number: "136",
                name: "Abdiás könyve",
                abbrev: "Abd",
                noOfChapters: 1),
            Book(
                number: "137",
                name: "Jónás könyve",
                abbrev: "Jón",
                noOfChapters: 4),
            Book(
                number: "138",
                name: "Mikeás könyve",
                abbrev: "Mik",
                noOfChapters: 7),
            Book(
                number: "139",
                name: "Náhum könyve",
                abbrev: "Náh",
                noOfChapters: 3),
            Book(
                number: "140",
                name: "Habakuk könyve",
                abbrev: "Hab",
                noOfChapters: 3),
            Book(
                number: "141",
                name: "Szofoniás könyve",
                abbrev: "Szof",
                noOfChapters: 3),
            Book(
                number: "142",
                name: "Aggeus könyve",
                abbrev: "Agg",
                noOfChapters: 2),
            Book(
                number: "143",
                name: "Zakariás könyve",
                abbrev: "Zak",
                noOfChapters: 14),
            Book(
                number: "144",
                name: "Malakiás könyve",
                abbrev: "Mal",
                noOfChapters: 3),
            Book(
                number: "145",
                name: "Makkabeusok I. könyve",
                abbrev: "1Mak",
                noOfChapters: 16),
            Book(
                number: "146",
                name: "Makkabeusok II. könyve",
                abbrev: "2Mak",
                noOfChapters: 15),
            
            
            Book(
                number: "201",
                name: "Máté evangéliuma",
                abbrev: "Mt",
                noOfChapters: 28),
            Book(
                number: "202",
                name: "Márk evangéliuma",
                abbrev: "Mk",
                noOfChapters: 16),
            Book(
                number: "203",
                name: "Lukács evangéliuma",
                abbrev: "Lk",
                noOfChapters: 24),
            Book(
                number: "204",
                name: "János evangéliuma",
                abbrev: "Jn",
                noOfChapters: 21),
            Book(
                number: "205",
                name: "Apostolok Cselekedetei",
                abbrev: "ApCsel",
                noOfChapters: 28),
            Book(
                number: "206",
                name: "Rómaiaknak írt levél",
                abbrev: "Róm",
                noOfChapters: 16),
            Book(
                number: "207",
                name: "Korintusiaknak írt I. levél",
                abbrev: "1Kor",
                noOfChapters: 16),
            Book(
                number: "208",
                name: "Korintusiaknak írt II. levél",
                abbrev: "2Kor",
                noOfChapters: 13),
            Book(
                number: "209",
                name: "Galatáknak írt levél",
                abbrev: "Gal",
                noOfChapters: 6),
            Book(
                number: "210",
                name: "Efezusiaknak írt levél",
                abbrev: "Ef",
                noOfChapters: 6),
            Book(
                number: "211",
                name: "Filippieknek írt levél",
                abbrev: "Fil",
                noOfChapters: 4),
            Book(
                number: "212",
                name: "Kolosszeieknek írt levél",
                abbrev: "Kol",
                noOfChapters: 4),
            Book(
                number: "213",
                name: "Tesszalonikaiaknak írt I. levél",
                abbrev: "1Tesz",
                noOfChapters: 5),
            Book(
                number: "214",
                name: "Tesszalonikaiaknak írt II. levél",
                abbrev: "2Tesz",
                noOfChapters: 3),
            Book(
                number: "215",
                name: "Timóteusnak írt I. levél",
                abbrev: "1Tim",
                noOfChapters: 6),
            Book(
                number: "216",
                name: "Timóteusnak írt II. levél",
                abbrev: "2Tim",
                noOfChapters: 3),
            Book(
                number: "217",
                name: "Titusznak írt levél",
                abbrev: "Tit",
                noOfChapters: 3),
            Book(
                number: "218",
                name: "Filemonnak írt levél",
                abbrev: "Fil",
                noOfChapters: 1),
            Book(
                number: "219",
                name: "Zsidóknak írt levél",
                abbrev: "Zsid",
                noOfChapters: 13),
            Book(
                number: "220",
                name: "Jakab levele",
                abbrev: "Jak",
                noOfChapters: 5),
            Book(
                number: "221",
                name: "Péter I. levele",
                abbrev: "1Pt",
                noOfChapters: 5),
            Book(
                number: "222",
                name: "Péter II. levele",
                abbrev: "2Pt",
                noOfChapters: 3),
            Book(
                number: "223",
                name: "János I. levele",
                abbrev: "1Jn",
                noOfChapters: 5),
            Book(
                number: "224",
                name: "János II. levele",
                abbrev: "2Jn",
                noOfChapters: 1),
            Book(
                number: "225",
                name: "János III. levele",
                abbrev: "3Jn",
                noOfChapters: 1),
            Book(
                number: "226",
                name: "Júdás levele",
                abbrev: "Júd",
                noOfChapters: 1),
            Book(
                number: "227",
                name: "Jelenések könyve",
                abbrev: "Jel",
                noOfChapters: 22),
        ]
    }
    
    static var UF: [Book] {
        [
            Book(
                number: "101",
                name: "Mózes első könyve",
                abbrev: "1Móz",
                noOfChapters: 50),
            Book(
                number: "102",
                name: "Mózes második könyve",
                abbrev: "2Móz",
                noOfChapters: 40),
            Book(
                number: "103",
                name: "Mózes harmadik könyve",
                abbrev: "3Móz",
                noOfChapters: 27),
            Book(
                number: "104",
                name: "Mózes negyedik könyve",
                abbrev: "4Móz",
                noOfChapters: 36),
            Book(
                number: "105",
                name: "Mózes ötödik könyve",
                abbrev: "5Móz",
                noOfChapters: 34),
            Book(
                number: "106",
                name: "Józsué könyve",
                abbrev: "Józs",
                noOfChapters: 24),
            Book(
                number: "107",
                name: "A bírák könyve",
                abbrev: "Bír",
                noOfChapters: 21),
            Book(
                number: "108",
                name: "Ruth könyve",
                abbrev: "Ruth",
                noOfChapters: 4),
            Book(
                number: "109",
                name: "Sámuel első könyve",
                abbrev: "1Sám",
                noOfChapters: 31),
            Book(
                number: "110",
                name: "Sámuel második könyve",
                abbrev: "2Sám",
                noOfChapters: 24),
            Book(
                number: "111",
                name: "A királyok első könyve",
                abbrev: "1Kir",
                noOfChapters: 22),
            Book(
                number: "112",
                name: "A királyok második könyve",
                abbrev: "2Kir",
                noOfChapters: 25),
            Book(
                number: "113",
                name: "A krónikák első könyve",
                abbrev: "1Krón",
                noOfChapters: 29),
            Book(
                number: "114",
                name: "A krónikák második könyve",
                abbrev: "2Krón",
                noOfChapters: 36),
            Book(
                number: "115",
                name: "Ezsdrás könyve",
                abbrev: "Ezsd",
                noOfChapters: 10),
            Book(
                number: "116",
                name: "Nehemiás könyve",
                abbrev: "Neh",
                noOfChapters: 13),
            Book(
                number: "119",
                name: "Eszter könyve",
                abbrev: "Eszt",
                noOfChapters: 10),
            Book(
                number: "120",
                name: "Jób könyve",
                abbrev: "Jób",
                noOfChapters: 42),
            Book(
                number: "121",
                name: "Zsoltárok könyve",
                abbrev: "Zsolt",
                noOfChapters: 150),
            Book(
                number: "122",
                name: "A példabeszédek könyve",
                abbrev: "Péld",
                noOfChapters: 31),
            Book(
                number: "123",
                name: "A prédikátor könyve",
                abbrev: "Préd",
                noOfChapters: 12),
            Book(
                number: "124",
                name: "Énekek éneke",
                abbrev: "Énekek",
                noOfChapters: 8),
            Book(
                number: "127",
                name: "Ézsaiás próféta könyve",
                abbrev: "Ézs",
                noOfChapters: 66),
            Book(
                number: "128",
                name: "Jeremiás próféta könyve",
                abbrev: "Jer",
                noOfChapters: 52),
            Book(
                number: "129",
                name: "Jeremiás siralmai",
                abbrev: "Jsir",
                noOfChapters: 5),
            Book(
                number: "131",
                name: "Ezékiel próféta könyve",
                abbrev: "Ez",
                noOfChapters: 48),
            Book(
                number: "132",
                name: "Dániel próféta könyve",
                abbrev: "Dán",
                noOfChapters: 14),
            Book(
                number: "133",
                name: "Hóseás próféta könyve",
                abbrev: "Hós",
                noOfChapters: 14),
            Book(
                number: "134",
                name: "Jóel könyve",
                abbrev: "Jóel",
                noOfChapters: 4),
            Book(
                number: "135",
                name: "Ámosz próféta könyve",
                abbrev: "Ám",
                noOfChapters: 9),
            Book(
                number: "136",
                name: "Abdiás próféta könyve",
                abbrev: "Abd",
                noOfChapters: 1),
            Book(
                number: "137",
                name: "Jónás próféta könyve",
                abbrev: "Jón",
                noOfChapters: 4),
            Book(
                number: "138",
                name: "Mikeás próféta könyve",
                abbrev: "Mik",
                noOfChapters: 7),
            Book(
                number: "139",
                name: "Náhum próféta könyve",
                abbrev: "Náh",
                noOfChapters: 3),
            Book(
                number: "140",
                name: "Habakuk próféta könyve",
                abbrev: "Hab",
                noOfChapters: 3),
            Book(
                number: "141",
                name: "Zofóniás próféta könyve",
                abbrev: "Zof",
                noOfChapters: 3),
            Book(
                number: "142",
                name: "Haggeus próféta könyve",
                abbrev: "Hag",
                noOfChapters: 2),
            Book(
                number: "143",
                name: "Zakariás próféta könyve",
                abbrev: "Zak",
                noOfChapters: 14),
            Book(
                number: "144",
                name: "Malakiás próféta könyve",
                abbrev: "Mal",
                noOfChapters: 3),
            
            Book(
                number: "201",
                name: "Máté evangéliuma",
                abbrev: "Mt",
                noOfChapters: 28),
            Book(
                number: "202",
                name: "Márk evangéliuma",
                abbrev: "Mk",
                noOfChapters: 16),
            Book(
                number: "203",
                name: "Lukács evangéliuma",
                abbrev: "Lk",
                noOfChapters: 24),
            Book(
                number: "204",
                name: "János evangéliuma",
                abbrev: "Jn",
                noOfChapters: 21),
            Book(
                number: "205",
                name: "Az apostolok cselekedetei",
                abbrev: "ApCsel",
                noOfChapters: 28),
            Book(
                number: "206",
                name: "Pál levele a rómaiakhoz",
                abbrev: "Róm",
                noOfChapters: 16),
            Book(
                number: "207",
                name: "Pál első levele a korinthusiakhoz",
                abbrev: "1Kor",
                noOfChapters: 16),
            Book(
                number: "208",
                name: "Pál második levele a korinthusiakhoz",
                abbrev: "2Kor",
                noOfChapters: 13),
            Book(
                number: "209",
                name: "Pál levele a galatákhoz",
                abbrev: "Gal",
                noOfChapters: 6),
            Book(
                number: "210",
                name: "Pál levele az efezusiakhoz",
                abbrev: "Ef",
                noOfChapters: 6),
            Book(
                number: "211",
                name: "Pál levele a filippiekhez",
                abbrev: "Fil",
                noOfChapters: 4),
            Book(
                number: "212",
                name: "Pál levele a kolosséiakhoz",
                abbrev: "Kol",
                noOfChapters: 4),
            Book(
                number: "213",
                name: "Pál első levele a thesszalonikaiakhoz",
                abbrev: "1Thessz",
                noOfChapters: 5),
            Book(
                number: "214",
                name: "Pál második levele a thesszalonikaiakhoz",
                abbrev: "2Thessz",
                noOfChapters: 3),
            Book(
                number: "215",
                name: "Pál első levele Timóteushoz",
                abbrev: "1Tim",
                noOfChapters: 6),
            Book(
                number: "216",
                name: "Pál második levele Timóteushoz",
                abbrev: "2Tim",
                noOfChapters: 3),
            Book(
                number: "217",
                name: "Pál levele Tituszhoz",
                abbrev: "Tit",
                noOfChapters: 3),
            Book(
                number: "218",
                name: "Pál levele Filemonhoz",
                abbrev: "Filem",
                noOfChapters: 1),
            Book(
                number: "219",
                name: "A zsidókhoz írt levél",
                abbrev: "Zsid",
                noOfChapters: 13),
            Book(
                number: "220",
                name: "Jakab levele",
                abbrev: "Jak",
                noOfChapters: 5),
            Book(
                number: "221",
                name: "Péter első levele",
                abbrev: "1Pt",
                noOfChapters: 5),
            Book(
                number: "222",
                name: "Péter második levele",
                abbrev: "2Pt",
                noOfChapters: 3),
            Book(
                number: "223",
                name: "János első levele",
                abbrev: "1Jn",
                noOfChapters: 5),
            Book(
                number: "224",
                name: "János második levele",
                abbrev: "2Jn",
                noOfChapters: 1),
            Book(
                number: "225",
                name: "János harmadik levele",
                abbrev: "3Jn",
                noOfChapters: 1),
            Book(
                number: "226",
                name: "Júdás levele",
                abbrev: "Júd",
                noOfChapters: 1),
            Book(
                number: "227",
                name: "A jelenések könyve",
                abbrev: "Jel",
                noOfChapters: 22),
        ]
    }
    
    static var KNB: [Book] {
        [
            Book(
                number: "101",
                name: "Teremtés könyve",
                abbrev: "Ter",
                noOfChapters: 50),
            Book(
                number: "102",
                name: "Kivonulás könyve",
                abbrev: "Kiv",
                noOfChapters: 40),
            Book(
                number: "103",
                name: "Leviták könyve",
                abbrev: "Lev",
                noOfChapters: 27),
            Book(
                number: "104",
                name: "Számok könyve",
                abbrev: "Szám",
                noOfChapters: 36),
            Book(
                number: "105",
                name: "Második Törvénykönyv",
                abbrev: "MTörv",
                noOfChapters: 34),
            Book(
                number: "106",
                name: "Józsué könyve",
                abbrev: "Józs",
                noOfChapters: 24),
            Book(
                number: "107",
                name: "Bírák könyve",
                abbrev: "Bír",
                noOfChapters: 21),
            Book(
                number: "108",
                name: "Rút könyve",
                abbrev: "Rút",
                noOfChapters: 4),
            Book(
                number: "109",
                name: "Sámuel első könyve",
                abbrev: "1Sám",
                noOfChapters: 31),
            Book(
                number: "110",
                name: "Sámuel második könyve",
                abbrev: "2Sám",
                noOfChapters: 24),
            Book(
                number: "111",
                name: "Királyok első könyve",
                abbrev: "1Kir",
                noOfChapters: 22),
            Book(
                number: "112",
                name: "Királyok második könyve",
                abbrev: "2Kir",
                noOfChapters: 25),
            Book(
                number: "113",
                name: "Krónikák első könyve",
                abbrev: "1Krón",
                noOfChapters: 29),
            Book(
                number: "114",
                name: "Krónikák második könyve",
                abbrev: "2Krón",
                noOfChapters: 36),
            Book(
                number: "115",
                name: "Ezdrás könyve",
                abbrev: "Ezd",
                noOfChapters: 10),
            Book(
                number: "116",
                name: "Nehemiás könyve",
                abbrev: "Neh",
                noOfChapters: 13),
            Book(
                number: "117",
                name: "Tóbiás könyve",
                abbrev: "Tób",
                noOfChapters: 14),
            Book(
                number: "118",
                name: "Judit könyve",
                abbrev: "Judit",
                noOfChapters: 16),
            Book(
                number: "119",
                name: "Eszter könyve",
                abbrev: "Esz",
                noOfChapters: 10),
            Book(
                number: "120",
                name: "Jób könyve",
                abbrev: "Jób",
                noOfChapters: 42),
            Book(
                number: "121",
                name: "A zsoltárok könyve",
                abbrev: "Zsolt",
                noOfChapters: 150),
            Book(
                number: "122",
                name: "A példabeszédek könyve",
                abbrev: "Péld",
                noOfChapters: 31),
            Book(
                number: "123",
                name: "A Prédikátor könyve",
                abbrev: "Préd",
                noOfChapters: 12),
            Book(
                number: "124",
                name: "Az énekek éneke",
                abbrev: "Én",
                noOfChapters: 8),
            Book(
                number: "125",
                name: "A bölcsesség könyve",
                abbrev: "Bölcs",
                noOfChapters: 19),
            Book(
                number: "126",
                name: "Jézus, Sirák fiának könyve",
                abbrev: "Sir",
                noOfChapters: 51),
            Book(
                number: "127",
                name: "Izajás könyve",
                abbrev: "Iz",
                noOfChapters: 66),
            Book(
                number: "128",
                name: "Jeremiás könyve",
                abbrev: "Jer",
                noOfChapters: 52),
            Book(
                number: "129",
                name: "Jeremiás siralmai",
                abbrev: "Siralm",
                noOfChapters: 5),
            Book(
                number: "130",
                name: "Báruk könyve",
                abbrev: "Bár",
                noOfChapters: 6),
            Book(
                number: "131",
                name: "Ezékiel jövendölése",
                abbrev: "Ez",
                noOfChapters: 48),
            Book(
                number: "132",
                name: "Dániel jövendölése",
                abbrev: "Dán",
                noOfChapters: 14),
            Book(
                number: "133",
                name: "Ózeás jövendölése",
                abbrev: "Óz",
                noOfChapters: 14),
            Book(
                number: "134",
                name: "Joel jövendölése",
                abbrev: "Jo",
                noOfChapters: 4),
            Book(
                number: "135",
                name: "Ámosz jövendölése",
                abbrev: "Ám",
                noOfChapters: 9),
            Book(
                number: "136",
                name: "Abdiás jövendölése",
                abbrev: "Abd",
                noOfChapters: 1),
            Book(
                number: "137",
                name: "Jónás jövendölése",
                abbrev: "Jón",
                noOfChapters: 4),
            Book(
                number: "138",
                name: "Mikeás jövendölése",
                abbrev: "Mik",
                noOfChapters: 7),
            Book(
                number: "139",
                name: "Náhum jövendölése",
                abbrev: "Náh",
                noOfChapters: 3),
            Book(
                number: "140",
                name: "Habakuk jövendölése",
                abbrev: "Hab",
                noOfChapters: 3),
            Book(
                number: "141",
                name: "Szofoniás jövendölése",
                abbrev: "Szof",
                noOfChapters: 3),
            Book(
                number: "142",
                name: "Aggeus jövendölése",
                abbrev: "Agg",
                noOfChapters: 2),
            Book(
                number: "143",
                name: "Zakariás jövendölése",
                abbrev: "Zak",
                noOfChapters: 14),
            Book(
                number: "144",
                name: "Malakiás jövendölése",
                abbrev: "Mal",
                noOfChapters: 3),
            Book(
                number: "145",
                name: "Makkabeusok első könyve",
                abbrev: "1Mak",
                noOfChapters: 16),
            Book(
                number: "146",
                name: "Makkabeusok második könyve",
                abbrev: "2Mak",
                noOfChapters: 15),
            
            
            Book(
                number: "201",
                name: "Evangélium Máté szerint",
                abbrev: "Mt",
                noOfChapters: 28),
            Book(
                number: "202",
                name: "Evangélium Márk szerint",
                abbrev: "Mk",
                noOfChapters: 16),
            Book(
                number: "203",
                name: "Evangélium Lukács szerint",
                abbrev: "Lk",
                noOfChapters: 24),
            Book(
                number: "204",
                name: "Evangélium János szerint",
                abbrev: "Jn",
                noOfChapters: 21),
            Book(
                number: "205",
                name: "Az apostolok Cselekedetei",
                abbrev: "Csel",
                noOfChapters: 28),
            Book(
                number: "206",
                name: "A rómaiaknak írt levél",
                abbrev: "Róm",
                noOfChapters: 16),
            Book(
                number: "207",
                name: "Első levél a korintusiaknak",
                abbrev: "1Kor",
                noOfChapters: 16),
            Book(
                number: "208",
                name: "Második levél a korintusiaknak",
                abbrev: "2Kor",
                noOfChapters: 13),
            Book(
                number: "209",
                name: "Levél a galatáknak",
                abbrev: "Gal",
                noOfChapters: 6),
            Book(
                number: "210",
                name: "Levél az efezusiaknak",
                abbrev: "Ef",
                noOfChapters: 6),
            Book(
                number: "211",
                name: "Levél a filippieknek",
                abbrev: "Fil",
                noOfChapters: 4),
            Book(
                number: "212",
                name: "Levél a kolosszeieknek",
                abbrev: "Kol",
                noOfChapters: 4),
            Book(
                number: "213",
                name: "Első levél a tesszalonikieknek",
                abbrev: "1Tesz",
                noOfChapters: 5),
            Book(
                number: "214",
                name: "Második levél a tesszalonikieknek",
                abbrev: "2Tesz",
                noOfChapters: 3),
            Book(
                number: "215",
                name: "Első levél Timóteusnak",
                abbrev: "1Tim",
                noOfChapters: 6),
            Book(
                number: "216",
                name: "Második levél Timóteusnak",
                abbrev: "2Tim",
                noOfChapters: 3),
            Book(
                number: "217",
                name: "Levél Títusznak",
                abbrev: "Tít",
                noOfChapters: 3),
            Book(
                number: "218",
                name: "Levél Filemonnak",
                abbrev: "Filem",
                noOfChapters: 1),
            Book(
                number: "219",
                name: "Levél a zsidóknak",
                abbrev: "Zsid",
                noOfChapters: 13),
            Book(
                number: "220",
                name: "Jakab levele",
                abbrev: "Jak",
                noOfChapters: 5),
            Book(
                number: "221",
                name: "Péter első levele",
                abbrev: "1Pét",
                noOfChapters: 5),
            Book(
                number: "222",
                name: "Péter második levele",
                abbrev: "2Pét",
                noOfChapters: 3),
            Book(
                number: "223",
                name: "János első levele",
                abbrev: "1Ján",
                noOfChapters: 5),
            Book(
                number: "224",
                name: "János második levele",
                abbrev: "2Ján",
                noOfChapters: 1),
            Book(
                number: "225",
                name: "János harmadik levele",
                abbrev: "3Ján",
                noOfChapters: 1),
            Book(
                number: "226",
                name: "Júdás levele",
                abbrev: "Júd",
                noOfChapters: 1),
            Book(
                number: "227",
                name: "János jelenései",
                abbrev: "Jel",
                noOfChapters: 22),
        ]
    }
    
    static var KG: [Book] {
        [
            Book(
                number: "101",
                name: "Mózes első könyve",
                abbrev: "1Móz",
                noOfChapters: 50),
            Book(
                number: "102",
                name: "Mózes második könyve",
                abbrev: "2Móz",
                noOfChapters: 40),
            Book(
                number: "103",
                name: "Mózes harmadik könyve",
                abbrev: "3Móz",
                noOfChapters: 27),
            Book(
                number: "104",
                name: "Mózes negyedik könyve",
                abbrev: "4Móz",
                noOfChapters: 36),
            Book(
                number: "105",
                name: "Mózes ötödik könyve",
                abbrev: "5Móz",
                noOfChapters: 34),
            Book(
                number: "106",
                name: "Józsué könyve",
                abbrev: "Józs",
                noOfChapters: 24),
            Book(
                number: "107",
                name: "Bírák könyve",
                abbrev: "Bir",
                noOfChapters: 21),
            Book(
                number: "108",
                name: "Ruth könyve",
                abbrev: "Ruth",
                noOfChapters: 4),
            Book(
                number: "109",
                name: "Sámuel első könyve",
                abbrev: "1Sám",
                noOfChapters: 31),
            Book(
                number: "110",
                name: "Sámuel második könyve",
                abbrev: "2Sám",
                noOfChapters: 24),
            Book(
                number: "111",
                name: "A királyok első könyve",
                abbrev: "1Kir",
                noOfChapters: 22),
            Book(
                number: "112",
                name: "A királyok második könyve",
                abbrev: "2Kir",
                noOfChapters: 25),
            Book(
                number: "113",
                name: "A krónikák első könyve",
                abbrev: "1Krón",
                noOfChapters: 29),
            Book(
                number: "114",
                name: "A krónikák második könyve",
                abbrev: "2Krón",
                noOfChapters: 36),
            Book(
                number: "115",
                name: "Ezsdrás könyve",
                abbrev: "Ezsd",
                noOfChapters: 10),
            Book(
                number: "116",
                name: "Nehemiás könyve",
                abbrev: "Neh",
                noOfChapters: 13),
            Book(
                number: "119",
                name: "Eszter könyve",
                abbrev: "Eszt",
                noOfChapters: 10),
            Book(
                number: "120",
                name: "Jób könyve",
                abbrev: "Jób",
                noOfChapters: 42),
            Book(
                number: "121",
                name: "Zsoltárok könyve",
                abbrev: "Zsolt",
                noOfChapters: 150),
            Book(
                number: "122",
                name: "A példabeszédek könyve",
                abbrev: "Péld",
                noOfChapters: 31),
            Book(
                number: "123",
                name: "A prédikátor könyve",
                abbrev: "Préd",
                noOfChapters: 12),
            Book(
                number: "124",
                name: "Énekek éneke",
                abbrev: "Ének.Én",
                noOfChapters: 8),
            Book(
                number: "127",
                name: "Ézsaiás próféta könyve",
                abbrev: "Ézs",
                noOfChapters: 66),
            Book(
                number: "128",
                name: "Jeremiás próféta könyve",
                abbrev: "Jer",
                noOfChapters: 52),
            Book(
                number: "129",
                name: "Jeremiás siralmai",
                abbrev: "Sir",
                noOfChapters: 5),
            Book(
                number: "131",
                name: "Ezékiel próféta könyve",
                abbrev: "Ez",
                noOfChapters: 48),
            Book(
                number: "132",
                name: "Dániel próféta könyve",
                abbrev: "Dán",
                noOfChapters: 14),
            Book(
                number: "133",
                name: "Hóseás próféta könyve",
                abbrev: "Hós",
                noOfChapters: 14),
            Book(
                number: "134",
                name: "Jóel könyve",
                abbrev: "Jóel",
                noOfChapters: 4),
            Book(
                number: "135",
                name: "Ámos próféta könyve",
                abbrev: "Ámós",
                noOfChapters: 9),
            Book(
                number: "136",
                name: "Abdiás próféta könyve",
                abbrev: "Abd",
                noOfChapters: 1),
            Book(
                number: "137",
                name: "Jónás próféta könyve",
                abbrev: "Jón",
                noOfChapters: 4),
            Book(
                number: "138",
                name: "Mikeás próféta könyve",
                abbrev: "Mik",
                noOfChapters: 7),
            Book(
                number: "139",
                name: "Náhum próféta könyve",
                abbrev: "Náh",
                noOfChapters: 3),
            Book(
                number: "140",
                name: "Habakuk próféta könyve",
                abbrev: "Hab",
                noOfChapters: 3),
            Book(
                number: "141",
                name: "Sofóniás próféta könyve",
                abbrev: "Sof",
                noOfChapters: 3),
            Book(
                number: "142",
                name: "Aggeus próféta könyve",
                abbrev: "Agg",
                noOfChapters: 2),
            Book(
                number: "143",
                name: "Zakariás próféta könyve",
                abbrev: "Zak",
                noOfChapters: 14),
            Book(
                number: "144",
                name: "Malakiás próféta könyve",
                abbrev: "Malak",
                noOfChapters: 3),
            //
            //            Újszövetség
            //
            Book(
                number: "201",
                name: "Máté evangéliuma",
                abbrev: "Mát",
                noOfChapters: 28),
            Book(
                number: "202",
                name: "Márk evangéliuma",
                abbrev: "Márk",
                noOfChapters: 16),
            Book(
                number: "203",
                name: "Lukács evangéliuma",
                abbrev: "Luk",
                noOfChapters: 24),
            Book(
                number: "204",
                name: "János evangéliuma",
                abbrev: "Ján",
                noOfChapters: 21),
            Book(
                number: "205",
                name: "Az apostolok cselekedetei",
                abbrev: "Csel",
                noOfChapters: 28),
            Book(
                number: "206",
                name: "Pál levele a rómaiakhoz",
                abbrev: "Róm",
                noOfChapters: 16),
            Book(
                number: "207",
                name: "Pál első levele a korinthusiakhoz",
                abbrev: "1Kor",
                noOfChapters: 16),
            Book(
                number: "208",
                name: "Pál második levele a korinthusiakhoz",
                abbrev: "2Kor",
                noOfChapters: 13),
            Book(
                number: "209",
                name: "Pál levele a galatákhoz",
                abbrev: "Gal",
                noOfChapters: 6),
            Book(
                number: "210",
                name: "Pál levele az efezusiakhoz",
                abbrev: "Eféz",
                noOfChapters: 6),
            Book(
                number: "211",
                name: "Pál levele a filippiekhez",
                abbrev: "Fil",
                noOfChapters: 4),
            Book(
                number: "212",
                name: "Pál levele a kolosséiakhoz",
                abbrev: "Kol",
                noOfChapters: 4),
            Book(
                number: "213",
                name: "Pál első levele a thesszalonikaiakhoz",
                abbrev: "1Thess",
                noOfChapters: 5),
            Book(
                number: "214",
                name: "Pál második levele a thesszalonikaiakhoz",
                abbrev: "2Thess",
                noOfChapters: 3),
            Book(
                number: "215",
                name: "Pál első levele Timóteushoz",
                abbrev: "1Tim",
                noOfChapters: 6),
            Book(
                number: "216",
                name: "Pál második levele Timóteushoz",
                abbrev: "2Tim",
                noOfChapters: 3),
            Book(
                number: "217",
                name: "Pál levele Tituszhoz",
                abbrev: "Tit",
                noOfChapters: 3),
            Book(
                number: "218",
                name: "Pál levele Filemonhoz",
                abbrev: "Filem",
                noOfChapters: 1),
            Book(
                number: "219",
                name: "A zsidókhoz írt levél",
                abbrev: "Zsid",
                noOfChapters: 13),
            Book(
                number: "220",
                name: "Jakab levele",
                abbrev: "Jak",
                noOfChapters: 5),
            Book(
                number: "221",
                name: "Péter első levele",
                abbrev: "1Pét",
                noOfChapters: 5),
            Book(
                number: "222",
                name: "Péter második levele",
                abbrev: "2Pét",
                noOfChapters: 3),
            Book(
                number: "223",
                name: "János első levele",
                abbrev: "1Ján",
                noOfChapters: 5),
            Book(
                number: "224",
                name: "János második levele",
                abbrev: "2Ján",
                noOfChapters: 1),
            Book(
                number: "225",
                name: "János harmadik levele",
                abbrev: "3Ján",
                noOfChapters: 1),
            Book(
                number: "226",
                name: "Júdás levele",
                abbrev: "Júd",
                noOfChapters: 1),
            Book(
                number: "227",
                name: "A jelenések könyve",
                abbrev: "Jel",
                noOfChapters: 22),
        ]
    }
    
    static var RUF: [Book] {
        [
            Book(
                number: "101",
                name: "Mózes első könyve",
                abbrev: "1Móz",
                noOfChapters: 50),
            Book(
                number: "102",
                name: "Mózes második könyve",
                abbrev: "2Móz",
                noOfChapters: 40),
            Book(
                number: "103",
                name: "Mózes harmadik könyve",
                abbrev: "3Móz",
                noOfChapters: 27),
            Book(
                number: "104",
                name: "Mózes negyedik könyve",
                abbrev: "4Móz",
                noOfChapters: 36),
            Book(
                number: "105",
                name: "Mózes ötödik könyve",
                abbrev: "5Móz",
                noOfChapters: 34),
            Book(
                number: "106",
                name: "Józsué könyve",
                abbrev: "Józs",
                noOfChapters: 24),
            Book(
                number: "107",
                name: "A bírák könyve",
                abbrev: "Bír",
                noOfChapters: 21),
            Book(
                number: "108",
                name: "Ruth könyve",
                abbrev: "Ruth",
                noOfChapters: 4),
            Book(
                number: "109",
                name: "Sámuel első könyve",
                abbrev: "1Sám",
                noOfChapters: 31),
            Book(
                number: "110",
                name: "Sámuel második könyve",
                abbrev: "2Sám",
                noOfChapters: 24),
            Book(
                number: "111",
                name: "A királyok első könyve",
                abbrev: "1Kir",
                noOfChapters: 22),
            Book(
                number: "112",
                name: "A királyok második könyve",
                abbrev: "2Kir",
                noOfChapters: 25),
            Book(
                number: "113",
                name: "A krónikák első könyve",
                abbrev: "1Krón",
                noOfChapters: 29),
            Book(
                number: "114",
                name: "A krónikák második könyve",
                abbrev: "2Krón",
                noOfChapters: 36),
            Book(
                number: "115",
                name: "Ezsdrás könyve",
                abbrev: "Ezsd",
                noOfChapters: 10),
            Book(
                number: "116",
                name: "Nehemiás könyve",
                abbrev: "Neh",
                noOfChapters: 13),
            Book(
                number: "119",
                name: "Eszter könyve",
                abbrev: "Eszt",
                noOfChapters: 10),
            Book(
                number: "120",
                name: "Jób könyve",
                abbrev: "Jób",
                noOfChapters: 42),
            Book(
                number: "121",
                name: "A zsoltárok könyve",
                abbrev: "Zsolt",
                noOfChapters: 150),
            Book(
                number: "122",
                name: "A példabeszédek könyve",
                abbrev: "Péld",
                noOfChapters: 31),
            Book(
                number: "123",
                name: "A prédikátor könyve",
                abbrev: "Préd",
                noOfChapters: 12),
            Book(
                number: "124",
                name: "Énekek éneke",
                abbrev: "Énekek",
                noOfChapters: 8),
            Book(
                number: "127",
                name: "Ézsaiás próféta könyve",
                abbrev: "Ézs",
                noOfChapters: 66),
            Book(
                number: "128",
                name: "Jeremiás próféta könyve",
                abbrev: "Jer",
                noOfChapters: 52),
            Book(
                number: "129",
                name: "Jeremiás siralmai",
                abbrev: "Jsir",
                noOfChapters: 5),
            Book(
                number: "131",
                name: "Ezékiel próféta könyve",
                abbrev: "Ez",
                noOfChapters: 48),
            Book(
                number: "132",
                name: "Dániel próféta könyve",
                abbrev: "Dán",
                noOfChapters: 14),
            Book(
                number: "133",
                name: "Hóseás próféta könyve",
                abbrev: "Hós",
                noOfChapters: 14),
            Book(
                number: "134",
                name: "Jóel könyve",
                abbrev: "Jóel",
                noOfChapters: 4),
            Book(
                number: "135",
                name: "Ámosz próféta könyve",
                abbrev: "Ám",
                noOfChapters: 9),
            Book(
                number: "136",
                name: "Abdiás próféta könyve",
                abbrev: "Abd",
                noOfChapters: 1),
            Book(
                number: "137",
                name: "Jónás próféta könyve",
                abbrev: "Jón",
                noOfChapters: 4),
            Book(
                number: "138",
                name: "Mikeás próféta könyve",
                abbrev: "Mik",
                noOfChapters: 7),
            Book(
                number: "139",
                name: "Náhum próféta könyve",
                abbrev: "Náh",
                noOfChapters: 3),
            Book(
                number: "140",
                name: "Habakuk próféta könyve",
                abbrev: "Hab",
                noOfChapters: 3),
            Book(
                number: "141",
                name: "Zofóniás próféta könyve",
                abbrev: "Zof",
                noOfChapters: 3),
            Book(
                number: "142",
                name: "Haggeus próféta könyve",
                abbrev: "Hag",
                noOfChapters: 2),
            Book(
                number: "143",
                name: "Zakariás próféta könyve",
                abbrev: "Zak",
                noOfChapters: 14),
            Book(
                number: "144",
                name: "Malakiás próféta könyve",
                abbrev: "Mal",
                noOfChapters: 3),
            //
            //          Újszövetség
            //
            Book(
                number: "201",
                name: "Máté evangéliuma",
                abbrev: "Mt",
                noOfChapters: 28),
            Book(
                number: "202",
                name: "Márk evangéliuma",
                abbrev: "Mk",
                noOfChapters: 16),
            Book(
                number: "203",
                name: "Lukács evangéliuma",
                abbrev: "Lk",
                noOfChapters: 24),
            Book(
                number: "204",
                name: "János evangéliuma",
                abbrev: "Jn",
                noOfChapters: 21),
            Book(
                number: "205",
                name: "Az apostolok cselekedetei",
                abbrev: "ApCsel",
                noOfChapters: 28),
            Book(
                number: "206",
                name: "Pál levele a rómaiakhoz",
                abbrev: "Róm",
                noOfChapters: 16),
            Book(
                number: "207",
                name: "Pál első levele a korinthusiakhoz",
                abbrev: "1Kor",
                noOfChapters: 16),
            Book(
                number: "208",
                name: "Pál második levele a korinthusiakhoz",
                abbrev: "2Kor",
                noOfChapters: 13),
            Book(
                number: "209",
                name: "Pál levele a galatákhoz",
                abbrev: "Gal",
                noOfChapters: 6),
            Book(
                number: "210",
                name: "Pál levele az efezusiakhoz",
                abbrev: "Ef",
                noOfChapters: 6),
            Book(
                number: "211",
                name: "Pál levele a filippiekhez",
                abbrev: "Fil",
                noOfChapters: 4),
            Book(
                number: "212",
                name: "Pál levele a kolosséiakhoz",
                abbrev: "Kol",
                noOfChapters: 4),
            Book(
                number: "213",
                name: "Pál első levele a thesszalonikaiakhoz",
                abbrev: "1Thessz",
                noOfChapters: 5),
            Book(
                number: "214",
                name: "Pál második levele a thesszalonikaiakhoz",
                abbrev: "2Thessz",
                noOfChapters: 3),
            Book(
                number: "215",
                name: "Pál első levele Timóteushoz",
                abbrev: "1Tim",
                noOfChapters: 6),
            Book(
                number: "216",
                name: "Pál második levele Timóteushoz",
                abbrev: "2Tim",
                noOfChapters: 3),
            Book(
                number: "217",
                name: "Pál levele Tituszhoz",
                abbrev: "Tit",
                noOfChapters: 3),
            Book(
                number: "218",
                name: "Pál levele Filemonhoz",
                abbrev: "Filem",
                noOfChapters: 1),
            Book(
                number: "219",
                name: "A zsidókhoz írt levél",
                abbrev: "Zsid",
                noOfChapters: 13),
            Book(
                number: "220",
                name: "Jakab levele",
                abbrev: "Jak",
                noOfChapters: 5),
            Book(
                number: "221",
                name: "Péter első levele",
                abbrev: "1Pt",
                noOfChapters: 5),
            Book(
                number: "222",
                name: "Péter második levele",
                abbrev: "2Pt",
                noOfChapters: 3),
            Book(
                number: "223",
                name: "János első levele",
                abbrev: "1Jn",
                noOfChapters: 5),
            Book(
                number: "224",
                name: "János második levele",
                abbrev: "2Jn",
                noOfChapters: 1),
            Book(
                number: "225",
                name: "János harmadik levele",
                abbrev: "3Jn",
                noOfChapters: 1),
            Book(
                number: "226",
                name: "Júdás levele",
                abbrev: "Júd",
                noOfChapters: 1),
            Book(
                number: "227",
                name: "A jelenések könyve",
                abbrev: "Jel",
                noOfChapters: 22),
        ]
    }
    
    static var `default`: Book {
        Book(number: "", name: "", abbrev: "", noOfChapters: 0)
    }
}

extension Book {
    struct Category: Identifiable {
        var id: Int
        var title: String
        var books: [Book]
    }
    
    static func getBooksByCategories(by translation: Translation) -> [Category] {
        let isCatholic = translation.denom == "katolikus"
        let categories = [
            Category(
                id: 0,
                title: "A Törvény könyvei",
                books: translation.books.filter({$0.number >= "101" && $0.number <= "105"})
            ),
            Category(
                id: 1,
                title: "Ószövetségi történelmi könyvek",
                books: translation.books.filter({$0.number >= "106" && $0.number <= "119"})
            ),
            Category(
                id: 2,
                title: "Költői könyvek",
                books: isCatholic ? translation.books.filter({$0.number >= "120" && $0.number <= "125"}) : translation.books.filter({$0.number >= "120" && $0.number <= "124"})
            ),
            Category(
                id: 3,
                title: "Ószövetség prófétai könyvek",
                books: translation.books.filter({$0.number >= "126" && $0.number <= (isCatholic ? "146" : "144")})
            ),
            Category(
                id: 4,
                title: "Evangéliumok",
                books: translation.books.filter({$0.number >= "201" && $0.number <= "204"})
            ),
            Category(
                id: 5,
                title: "Újszövetség történelmi könyvek",
                books: translation.books.filter({$0.number == "205"})
            ),
            Category(
                id: 6,
                title: "Levelek",
                books: translation.books.filter({$0.number >= "206" && $0.number <= "226"})
            ),
            Category(
                id: 7,
                title: "Újszövetség prófétai könyvek",
                books: translation.books.filter({$0.number == "227"})
            )
        ]
        
        return categories
    }
    
}

extension Book {
    func save() {
        UserDefaults.standard.set(self.number, forKey: UserDefaultsKeys.book.rawValue)
    }
    
    static func load() -> Book {
        let translation = Translation.load()
        let number = UserDefaults.standard.string(forKey: UserDefaultsKeys.book.rawValue) ?? "101"
        return translation.books.first(where: {$0.number == number}) ?? translation.books[0]
    }
}


extension Book {
    var isCatholic: Bool {
        return self.number == "117"
        || self.number == "118"
        || self.number == "125"
        || self.number == "126"
        || self.number == "130"
        || self.number == "145"
        || self.number == "146"
    }
}
