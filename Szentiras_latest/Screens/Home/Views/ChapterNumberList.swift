//
//  ChapterNumberList.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 16..
//

import SwiftUI
import LoggerKit

struct ChapterNumberList: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @EnvironmentObject var appState: AppState
    var book: Book
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 55), spacing: 20)]
    
    var body: some View {
        VStack(spacing: 0) {
            Header(title: book.name)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(1...book.noOfChapters, id:\.self) { index in                        
                        NavigationLink(value: Route.chapter(index)) {
                            ButtonText("\(index)", selected: appState.chapter == index)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {            
            appState.book = book
        }
        .navigationBarBackButtonHidden(true)
    }
}

extension ChapterNumberList {
    struct Header: View {
        @EnvironmentObject var navigationRouter: NavigationRouter
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
                        navigationRouter.routes = []
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
    static var book = Book(number: "101", name: "Mózes 1. könyve", abbrev: "1Móz", noOfChapters: 50)
    static var previews: some View {
        NavigationStack {
            ChapterNumberList(book: book)
                .environmentObject(AppState())
                .environmentObject(NavigationRouter())
        }
    }
}
