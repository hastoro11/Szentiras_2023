//
//  ChapterViewModel.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 17..
//

import SwiftUI

class ChapterViewModel: ObservableObject {
    @Published var chapter: Chapter = .default
    
}