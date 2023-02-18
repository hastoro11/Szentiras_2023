//
//  Resource.swift
//  NetworkTest
//
//  Created by Gabor Sornyei on 2023. 01. 20..
//

import Foundation

protocol Resource {    
    var host: String { get }
    var path: String { get }
}

extension Resource {
    var url: URL {
        get throws {
            var components = URLComponents()
            components.scheme = "https"
            components.host = host
            components.path = path
            
            if let url = components.url {
                return url
            }
            
            throw URLError(.badURL)
        }
    }
}
