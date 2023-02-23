//
//  API.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import Foundation

enum API {
    case chapter(String)
    case search(String)
}

extension API: Resource {
    var host: String  {
        "szentiras.hu"
    }
    
    var path: String {
        switch self {
        case .chapter(let details):
            return "/api/idezet/\(details)"
        case .search(let search):
            return "/api/search/\(search)"
        }
    }
}
