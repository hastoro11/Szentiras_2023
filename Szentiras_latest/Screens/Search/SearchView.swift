//
//  SearchView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 21..
//

import SwiftUI
import LoggerKit

struct SearchView: View {
    @State var search = ""
    @State var showFilterView = false
    @State var searchFilter = SearchFilter()
    @StateObject var vm: SearchViewModel = SearchViewModel()
    
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
            header
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
        }
    }
    
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
    
    var header: some View {
        VStack {
            HStack {
                Text("Keresés")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }
        }
        .padding()
        .background {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.top)
        }
    }
    
    var versList: some View {
        List {
            ForEach(filteredVerses) { vers in
                VersRow(vers: vers)
            }
        }
        .listStyle(.plain)
    }
    
}

extension SearchView {
    struct VersRow: View {
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

struct SearchView_Previews: PreviewProvider {
    static var searchVM: SearchViewModel {
        let vm = SearchViewModel()
        vm.fullResult = try! Util.getSZISearch(filename: "result_sample").fullTextResult!
        return vm
    }
    static var previews: some View {
        SearchView(vm: searchVM)
    }
}
