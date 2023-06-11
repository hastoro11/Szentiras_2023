//
//  NavigationRouter.swift
//  Szentiras
//
//  Created by Gabor Sornyei on 2023. 06. 11..
//

import SwiftUI

enum Route {
    case numbers(Book)
    case chapter(Int)
}

extension Route: Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.numbers(let lhs), .numbers(let rhs)):
            return lhs.id == rhs.id
        case (.chapter(let lhs), .chapter(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}

extension Route: View {
    var body: some View {
        switch self {
        case .numbers(let book):
            ChapterNumberList(book: book)
        case .chapter(let chapter):
            ChapterView(index: chapter)
        }
    }
}

class NavigationRouter: ObservableObject {
    @Published var routes: [Route]
    
    init() {
        self.routes = []
    }
    
}
