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
        ZStack {
            VStack(spacing: 0) {
                navigationHeader
                versList
            }
            .isLoading($vm.isLoading)
            .showError(isPresented: $vm.isError, error: vm.error, guidance: "A szerver nem, vagy hibásan működik. Érdemes újra próbálkozni, vagy újraindítani a keresést.")
        }
    }
    
    @ViewBuilder
    var versList: some View {
        List {
            chapterHeader
            if chapter.verses.isEmpty {
                versRow(index: 1, text: "????????? ???????? ??????? ??????? ???????? ??")
                versRow(index: 2, text: "????????? ???????? ??????? ??????? ???????? ???????? ???????? ????")
                versRow(index: 3, text: "????????? ???????? ??????? ??????? ???????? ???????? ????? ???? ????????????????????????????????????????????")
                versRow(index: 4, text: "????????? ???????? ??????? ??????? ???????? ????????")
                
            } else {
                ForEach(chapter.verses) { vers in
                    versRow(index: vers.versIndex, text: vers.text)
                }
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    func versRow(index: Int, text: String) -> some View {
        VStack {
            Text("\(index)  ")
                .foregroundColor(.darkGreen)
                .fontWeight(.heavy) +
            Text(text.html)
                .fontWeight(.light)
        }
        .lineSpacing(4)
    }
    
    @ViewBuilder
    var chapterHeader: some View {
        VStack(alignment: .leading) {
            Text(chapter.book.name.isEmpty ? "????? ?????" : chapter.book.name)
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
                Text(chapter.book.abbrev.isEmpty ? "???" : chapter.book.abbrev)
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
                Text(chapter.translationAbbrev.isEmpty ? "???" : chapter.translationAbbrev)
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
    
    static var emptyVm: ChapterViewModel {
        let vm = ChapterViewModel()
        vm.isError = true
        vm.error = APIError(statusCode: 0)
        return vm
    }
    
    static var loadingVm: ChapterViewModel {
        let vm = ChapterViewModel()
        vm.isLoading = true
        return vm
    }
    static var previews: some View {
        Group {
            ChapterView(vm: successVm)
                .previewDisplayName("Success")
            ChapterView(vm: emptyVm)
                .previewDisplayName("Error")
            ChapterView(vm: loadingVm)
                .previewDisplayName("Loading")
        }
    }
}
