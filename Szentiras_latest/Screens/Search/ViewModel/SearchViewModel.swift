//
//  SearchViewModel.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 22..
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var fullResult: FullTextResult = FullTextResult.default
}

