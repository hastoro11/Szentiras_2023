//
//  SearchContext.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 25..
//

import SwiftUI

struct SearchContext: View {
    @StateObject var chapterVM: ChapterViewModel = ChapterViewModel()
    var selectedVers: FullTextResult.Vers
    var body: some View {
        VStack(spacing: 0) {
            SearchHeader(text: "\(selectedVers.translationAbbrev) - \(selectedVers.bookAbbrev) \(selectedVers.chapter)", showButton: true)
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        ChapterHeader(book: chapterVM.chapter.book.name, chapter: chapterVM.chapter.current)
                            .padding()
                        Divider()
                            .padding(.horizontal)
                        ForEach(chapterVM.chapter.verses) { vers in
                            VersRow(index: vers.versIndex, text: vers.text)
                                .id(vers.versIndex)
                                .padding(.horizontal)
                                .background {
                                    Rectangle()
                                        .fill(vers.versIndex == selectedVers.numv ? Color(.systemGray5) : .clear)
                                        .padding(.horizontal)
                                        
                                }
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .onAppear {
                    scrollTo(proxy: scrollViewProxy, vers: selectedVers.numv)
                }
            }
        }
        .isLoading($chapterVM.isLoading)
        .task {
            await chapterVM.fetchChapter(details: selectedVers.reference)
        }
        
    }
    
    func scrollTo(proxy: ScrollViewProxy, vers: Int) {
        proxy.scrollTo(vers, anchor: .center)
    }
}

struct ContextVersRow: View {
    var index: Int
    var text: String
    var body: some View {
        VStack {
            Text("\(index)  ")
                .foregroundColor(.darkGreen)
                .fontWeight(.heavy) +
            Text(text.html)
                .fontWeight(.light)
        }
        .lineSpacing(4)
    }
}

struct SearchContext_Previews: PreviewProvider {
    static var previews: some View {
        SearchContext(selectedVers: FullTextResult.Vers(bookNumber: "101", bookAbbrev: "1Móz", translationID: 6, translationAbbrev: "RUF", chapter: 1, numv: 1, text: "Mert nagy az ő szeretete irántunk, az ÚR hűsége örökké tart. Dicsérjétek az URat!"))
    }
}
