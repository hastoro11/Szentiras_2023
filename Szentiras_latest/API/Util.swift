//
//  Util.swift
//  Szentiras_v3
//
//  Created by Gabor Sornyei on 2022. 11. 12..
//

import Foundation

struct Util {
    static func getSZIResponse(filename: String) throws -> SZIResponse  {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "com.szentiras", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error with url"])
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(SZIResponse.self, from: data)
        return response        
    }
    
    static func getSZISearch(filename: String) throws -> SZISearch  {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            throw NSError(domain: "com.szentiras", code: 0, userInfo: [NSLocalizedDescriptionKey : "Error with url"])
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let search = try decoder.decode(SZISearch.self, from: data)
        return search
    }
}
