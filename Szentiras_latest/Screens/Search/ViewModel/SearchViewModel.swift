//
//  SearchViewModel.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 22..
//

import SwiftUI
import LoggerKit

class SearchViewModel: ObservableObject {
    @Published var fullResult: FullTextResult?
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var error: APIError?
    
    @Published var searched: Bool = false
    
    @MainActor
    func search(for phrase: String) async {
        self.isLoading = true
        defer {
            self.isLoading = false
        }
        do {
            let search: SZISearch = try await NetworkService().fetchSearch(search: phrase)
            if let fullResult = search.fullTextResult {
                self.fullResult = fullResult
            } else {
                self.fullResult = nil
            }
        } catch {
#if DEBUG
            Logger.error(error)
#endif
            if let error = error as? APIError {
                self.error = error
            } else {
                self.error = APIError.init(statusCode: 0)
            }
        }
    }    
}

