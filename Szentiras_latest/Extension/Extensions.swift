//
//  Extensions.swift
//  Szentiras_v4
//
//  Created by Gabor Sornyei on 2023. 01. 01..
//

import SwiftUI

extension Color {
    static var darkGreen: Color {
        Color("darkGreen")
    }
    
    static var bgGray: Color {
        Color("bgGray")
    }
    
    static var textGray: Color {
        Color(uiColor: .systemGray2)
    }
}



extension String {
    var html: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}


