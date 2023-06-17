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
    @EnvironmentObject var navigationRouter: NavigationRouter
    @StateObject var vm: ChapterViewModel = ChapterViewModel()
    @State var showTranslations: Bool = false
    @State var showFontSize: Bool = false
    // with the verses
    var chapter: Chapter {
        vm.chapter
    }
    // chapter number
    var index: Int
    
    var errorMessage: String {
        var message = "A szerver nem, vagy hibásan működik. Érdemes újra próbálkozni, vagy újraindítani a keresést."
        if appState.book.number == "118" && appState.translation == .SZIT {
            message = "Judit könyvét érdemes a KNB fordításban megnézni, onnan váltani a SZIT fordításra"
        }
        return message
    }
    
    var fontSizes: [CGFloat] = [17, 19, 21, 23, 25, 27, 31]
    @State var fontSizeIndex: Int = 1
    
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
                navigationRouter.routes = [.numbers(appState.book)]
            }, againAction: {
                Task {
                    await vm.fetchChapter(translation: appState.translation, book: appState.book, chapter: appState.chapter)
                }
            })
            .task {
                await vm.fetchChapter(translation: appState.translation, book: appState.book, chapter: index)                
            }
            .sheet(isPresented: $showTranslations) {
                TranslationList()
            }
            .sheet(isPresented: $showFontSize) {
                VStack(spacing: 25) {
                    Capsule()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 100, height: 3)
                        
                    Stepper(value: $fontSizeIndex, in: 0...6) {
                        Text("Betűméret")
                            .font(.headline)
                    }
                    .padding(.horizontal)
                    .presentationDetents([.fraction(0.15)])
                    Spacer()
                }
                .padding(.top)
            }
            .onAppear {
                appState.chapter = index
            }
        }
    }
    
    // MARK: - verslist
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
                    if vers.versIndex == 0 {
                        Text(vers.text.html)
                            .italic()
                            .font(.system(size: fontSizes[fontSizeIndex]-2, weight: .light, design: .default))
                            .foregroundColor(Color(uiColor: .systemGray))
                            .lineSpacing(4)                            
                    } else {
                        VersRow(index: vers.versIndex, text: vers.text)
                            .font(.system(size: fontSizes[fontSizeIndex]))
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    @ViewBuilder
    var navigationHeader: some View {
        HStack {
            Spacer()
            Button("Aa", action: {
                showFontSize.toggle()
            })
            .font(.headline)
            .foregroundColor(.darkGreen)
            .buttonStyle(.bordered)
            Button(action: {
                appState.chapter = 0
                navigationRouter.routes = []
            }) {
                Text(chapter.book.abbrev.isEmpty ? "???" : chapter.book.abbrev)
                    .font(.headline)
                    .foregroundColor(.darkGreen)
            }
            .buttonStyle(.bordered)
            Button(action: {
                navigationRouter.routes = [.numbers(appState.book)]
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
            return try! Util.getSZIResponse(filename: "RUF_Zsolt_51")
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
            ChapterView(vm: successVm, index: 1)
                .environmentObject(AppState())
                .environmentObject(NavigationRouter())
                .previewDisplayName("Success")
            ChapterView(vm: emptyVm, index: 2)
                .environmentObject(AppState())
                .environmentObject(NavigationRouter())
                .previewDisplayName("Error")
            ChapterView(vm: loadingVm, index: 3)
                .environmentObject(AppState())
                .environmentObject(NavigationRouter())
                .previewDisplayName("Loading")
        }
        
    }
}
