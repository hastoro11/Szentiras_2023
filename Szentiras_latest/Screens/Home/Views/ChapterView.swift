//
//  ChapterView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 17..
//

import SwiftUI
import LoggerKit

struct ChapterView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var vm: ChapterViewModel = ChapterViewModel()
    @Binding var path: NavigationPath
    @State var showTranslations: Bool = false
    var chapter: Chapter {
        vm.chapter
    }
    var errorMessage: String {
        var message = "A szerver nem, vagy hibásan működik. Érdemes újra próbálkozni, vagy újraindítani a keresést."
        if appState.book.number == "118" && appState.translation == .SZIT {
            message = "Judit könyvét érdemes a KNB fordításban megnézni, onnan váltani a SZIT fordításra"
        }
        return message
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
            .showError(isPresented: $vm.isError, error: vm.error, guidance: errorMessage, backAction: {
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
            ChapterHeader(book: chapter.book.name, chapter: chapter.current)
            if chapter.verses.isEmpty {
                VersRow(index: 1, text: "????????? ???????? ??????? ??????? ???????? ??")
                VersRow(index: 2, text: "????????? ???????? ??????? ??????? ???????? ???????? ???????? ????")
                VersRow(index: 3, text: "????????? ???????? ??????? ??????? ???????? ???????? ????? ???? ????????????????????????????????????????????")
                VersRow(index: 4, text: "????????? ???????? ??????? ??????? ???????? ????????")
                
            } else {
                ForEach(chapter.verses) { vers in
                    VersRow(index: vers.versIndex, text: vers.text)
                }
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    var navigationHeader: some View {
        HStack {
            Spacer()
            Button(action: {
                appState.chapter = 0
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
