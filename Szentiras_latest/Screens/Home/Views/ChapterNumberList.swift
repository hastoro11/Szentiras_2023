//
//  ChapterNumberList.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 16..
//

import SwiftUI

struct ChapterNumberList: View {
    var book: Book
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 55), spacing: 20)]
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 0) {
            Header(title: book.name)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(1...book.noOfChapters, id:\.self) { index in
                        Button(action: {
                            path = NavigationPath()
                        }) {
                            ButtonText("\(index)")
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
        @Environment(\.dismiss) var dismiss
        var title: String
        var body: some View {
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                    Spacer()
                    Button(action: {
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
            ChapterNumberList(book: Translation.RUF.books[12], path: .constant(NavigationPath()))
        }
    }
}
