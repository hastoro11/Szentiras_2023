//
//  BookList.swift
//  Szentiras_v4
//
//  Created by Gabor Sornyei on 2023. 01. 01..
//

import SwiftUI

struct BookList: View {
    typealias Category = Book.Category
    var categories: [Category] = Book.getBooksByCategories(by: .RUF)
    @State var path: NavigationPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                Header(title: "Könyvek")
                List(categories) { cat in
                    Section {
                        ForEach(cat.books) { book in
                            NavigationLink(book.name, value: book)
                        }
                    } header: {
                        Text(cat.title)
                            .foregroundColor(.darkGreen)
                            .padding(.bottom, 6)
                    }
                }
                .listStyle(.plain)
            }
            .navigationDestination(for: Book.self) { book in
                ChapterNumberList(book: book, path: $path)
            }
        }
    }
}

extension BookList {    
    struct Header: View {
        var title: String
        var body: some View {
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                }
            }
            .padding()
            .background {
                Color(.systemGray6)
                    .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookList()
        }
    }
}
