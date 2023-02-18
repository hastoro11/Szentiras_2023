//
//  ChapterView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 17..
//

import SwiftUI

struct ChapterView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm: ChapterViewModel = ChapterViewModel()
    @Binding var path: NavigationPath
    @State var showTranslations: Bool = false
    var chapter: Chapter {
        vm.chapter
    }
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                navigationHeader
                versList
            }
            .onChange(of: appState.translation, perform: { _ in
                Task {
                    await vm.fetchChapter(translation: appState.translation, book: appState.book, chapter: appState.chapter)
                }
            })
            .navigationBarBackButtonHidden(true)
            .isLoading($vm.isLoading)
            .showError(isPresented: $vm.isError, error: vm.error, guidance: "A szerver nem, vagy hibásan működik. Érdemes újra próbálkozni, vagy újraindítani a keresést.", backAction: {
                path = NavigationPath()
            }, againAction: {
                Task {
                    await vm.fetchChapter(translation: appState.translation, book: appState.book, chapter: appState.chapter)
                }
            })
            .task {
                await vm.fetchChapter(translation: appState.translation, book: appState.book, chapter: appState.chapter)
            }
            .sheet(isPresented: $showTranslations) {
                TranslationList()
            }
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
            Button(action: {
                path = NavigationPath()
            }) {
                Text(chapter.book.abbrev.isEmpty ? "???" : chapter.book.abbrev)
                    .font(.headline)
                    .foregroundColor(.darkGreen)
            }
            .buttonStyle(.bordered)
            Button(action: {
                path.removeLast()
            }) {
                Text("\(chapter.current)")
                    .font(.headline)
                    .foregroundColor(.darkGreen)
            }
            .buttonStyle(.bordered)
            Button(action: {
                showTranslations.toggle()
            }) {
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
        let vm = ChapterViewModel(service: MockService(stub: {
            return try! Util.getSZIResponse(filename: "sample2")
        }))
        
        return vm
    }
    
    static var emptyVm: ChapterViewModel {
        let vm = ChapterViewModel(service: MockService(stub: {
            throw APIError(statusCode: 0)
        }))

        return vm
    }
    
    static var loadingVm: ChapterViewModel {
        let vm = ChapterViewModel(service: MockService(stub: {
            await withCheckedContinuation({ _ in
                
            })
        }))
        
        return vm
    }
    static var previews: some View {
        Group {
            ChapterView(vm: successVm, path: .constant(NavigationPath()))
                .environmentObject(AppState())
                .previewDisplayName("Success")
            ChapterView(vm: emptyVm, path: .constant(NavigationPath()))
                .environmentObject(AppState())
                .previewDisplayName("Error")
            ChapterView(vm: loadingVm, path: .constant(NavigationPath()))
                .environmentObject(AppState())
                .previewDisplayName("Loading")
        }
        
    }
}
