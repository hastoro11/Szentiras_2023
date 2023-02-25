//
//  SearchView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 21..
//

import SwiftUI
import LoggerKit

// MARK: - SearchView
struct SearchView: View {
    @State var search = ""
    @State var showFilterView = false
    @State var searchFilter = SearchFilter()
    @StateObject var vm: SearchViewModel = SearchViewModel()
    
    @State var showChapter: Bool = false
    @State var selectedVers: FullTextResult.Vers?
    
    var filteredVerses: [FullTextResult.Vers] {
        var results = vm.fullResult?.verses ?? []
        switch searchFilter.testament {
        case .newTestament:
            results = results.filter { $0.bookNumber > "200"}
        case .oldTestament:
            results = results.filter { $0.bookNumber < "200"}
        default:
            break
        }
        if searchFilter.book != "" {
            results = results.filter { $0.bookNumber == searchFilter.book }
        }
        if searchFilter.translation != "" {
            results = results.filter { $0.translationAbbrev == searchFilter.translation}
        }
        return results.sorted(by: {$0.bookNumber < $1.bookNumber })
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            SearchHeader(text: "Keresés")
                .padding(.bottom)
            VStack {
                SearchField(text: $search, onCommit: {
                    Task {
                        await vm.search(for:search)
                        vm.searched = true
                    }
                }, onClear: {
                    vm.fullResult = nil
                    vm.searched = false
                }, onCancel: {
                    vm.fullResult = nil
                    vm.searched = false
                })
                .padding(.horizontal)
                
                FilterView(count: filteredVerses.count, showFilterView: $showFilterView, searchFilter: $searchFilter)
                    .padding(.horizontal)
                
                versList
                    .isLoading($vm.isLoading)
                    .overlay {
                        if vm.fullResult == nil {
                            overlay()
                        }
                    }
            }
            .fullScreenCover(item: $selectedVers) { vers in
                SearchContext(selectedVers: vers)
            }
        }
    }
    
    // MARK: - Overlay property
    @ViewBuilder
    func overlay() -> some View {
        VStack {
            Spacer()
            Text(vm.searched ? "Nincs találat" : "Írj be egy kifejezést a kereséshez")
                .fontWeight(.light)
            Spacer()
            Spacer()
        }
    }
    
    // MARK: - VersList property
    var versList: some View {
        List {
            ForEach(filteredVerses) { vers in
                SearchVersRow(vers: vers)
                    .onTapGesture {
                        selectedVers = vers
                        showChapter = true
                    }
            }
        }
        .listStyle(.plain)
    }
}

// MARK: - VersRow
extension SearchView {
    struct SearchVersRow: View {
        var vers: FullTextResult.Vers
        var reference: String {
            "\(vers.bookAbbrev) \(vers.chapter): \(vers.numv)"
        }
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(reference)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(vers.translationAbbrev)
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
                
                Text(vers.text.html)
                    .fontWeight(.light)
                    .lineLimit(3)
                    .lineSpacing(4)
            }
            
        }
    }
}

// MARK: - Previews
struct SearchView_Previews: PreviewProvider {
    static var searchVM: SearchViewModel {
        let vm = SearchViewModel()
        vm.fullResult = try! Util.getSZISearch(filename: "result_sample").fullTextResult!
        return vm
    }
    static var previews: some View {
        Group {
            SearchView(vm: searchVM)
            
            ScrollView {
                ContextVersRow(index: 1, text: "Ura nagyon jól tudta, hogy az Úr vele van, és mindent, amit csinál sikeressé teszi a kezében.")
                    .padding()
                ContextVersRow(index: 1, text: "Ura nagyon jól tudta, hogy az Úr vele van, és mindent, amit csinál sikeressé teszi a kezében.")
                    .padding()
            }
        }
    }
}
