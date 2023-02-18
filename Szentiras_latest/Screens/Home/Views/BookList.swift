//
//  BookList.swift
//  Szentiras_v4
//
//  Created by Gabor Sornyei on 2023. 01. 01..
//

import SwiftUI

struct BookList: View {
    @EnvironmentObject var appState: AppState
    typealias Category = Book.Category
    var categories: [Category] {
        Book.getBooksByCategories(by: appState.translation)
    }
    @State var path: NavigationPath = NavigationPath()
    @State var showTranslationList: Bool = false
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                header
                List(categories) { cat in
                    Section {
                        ForEach(cat.books) { book in
                            NavigationLink(value: TranslationBook(translation: appState.translation, book: book)) {
                                Text(book.name)
                            }
                        }
                    } header: {
                        Text(cat.title)
                            .foregroundColor(.darkGreen)
                            .padding(.bottom, 6)
                    }
                }
                .listStyle(.plain)
            }
            .navigationDestination(for: TranslationBook.self) { translationBook in
                ChapterNumberList(translationBook: translationBook, path: $path)
            }
            .navigationDestination(for: TranslationBookChapter.self) { _ in
                ChapterView(path: $path)
            }
            .sheet(isPresented: $showTranslationList) {
                TranslationList()
            }
        }
    }
    
    @ViewBuilder
    var header: some View {
        VStack {
            HStack {
                Text("Könyvek")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showTranslationList.toggle()
                }) {
                    Text(appState.translation.rawValue)
                        .font(.headline)
                        .foregroundColor(.darkGreen)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .background {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.top)
        }
    }
}

struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BookList()
                .environmentObject(AppState())
        }
    }
}
