//
//  ChapterNumberList.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 16..
//

import SwiftUI

struct ChapterNumberList: View {
    @EnvironmentObject var appState: AppState
    var translationBook: TranslationBook
    var book: Book {
        translationBook.book
    }
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 55), spacing: 20)]
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 0) {
            Header(title: book.name)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(1...book.noOfChapters, id:\.self) { index in
                        Button(action: {
                            appState.translation = translationBook.translation
                            appState.book = translationBook.book
                            appState.chapter = index
                            path.append(TranslationBookChapter(translation: appState.translation, book: appState.book, chapter: appState.chapter))
                        }) {
                            ButtonText("\(index)", selected: appState.chapter == index)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension ChapterNumberList {
    struct Header: View {
        @EnvironmentObject var appState: AppState
        @Environment(\.dismiss) var dismiss
        var title: String
        var body: some View {
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        appState.chapter = 0
                        dismiss()
                    }) {
                        Text("Vissza")
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
}

struct ChapterNumberList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChapterNumberList(translationBook: TranslationBook(translation: .RUF, book: Translation.RUF.books[12]), path: .constant(NavigationPath()))
                .environmentObject(AppState())
        }
    }
}
