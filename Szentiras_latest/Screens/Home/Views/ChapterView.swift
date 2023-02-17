//
//  ChapterView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 17..
//

import SwiftUI

struct ChapterView: View {
    @StateObject var vm: ChapterViewModel = ChapterViewModel()
    var chapter: Chapter {
        vm.chapter
    }
    var body: some View {
        VStack(spacing: 0) {
            navigationHeader
            versList
        }
    }
    
    @ViewBuilder
    var versList: some View {
        List {
            chapterHeader
            ForEach(chapter.verses) { vers in
                VStack {
                    Text("\(vers.versIndex)  ")
                        .foregroundColor(.darkGreen)
                        .fontWeight(.heavy) +
                    Text(vers.text.html)
                        .fontWeight(.light)
                }
                .lineSpacing(4)
                
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    var chapterHeader: some View {
        VStack(alignment: .leading) {
            Text(chapter.book.name)
                .font(.system(.largeTitle, design: .default, weight: .bold))
            Text("\(chapter.current). fejezet")
                .font(.system(.title3, design: .serif, weight: .light))
                .italic()
                .foregroundColor(Color(.systemGray))
        }
    }
    
    @ViewBuilder
    var navigationHeader: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                Text(chapter.book.abbrev)
                    .font(.headline)
                    .foregroundColor(.darkGreen)
            }
            .buttonStyle(.bordered)
            Button(action: {}) {
                Text("\(chapter.current)")
                    .font(.headline)
                    .foregroundColor(.darkGreen)
            }
            .buttonStyle(.bordered)
            Button(action: {}) {
                Text(chapter.translationAbbrev)
                    .font(.headline)
                    .foregroundColor(.darkGreen)
            }
            .buttonStyle(.bordered)
        }
        
        .padding()
        .background {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.top)
        }
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var successVm: ChapterViewModel {
        let vm = ChapterViewModel()
        vm.chapter = try! Util.getSZIResponse(filename: "sample2").chapter
        return vm
    }
    static var previews: some View {
        ChapterView(vm: successVm)
    }
}
