//
//  SearchView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 21..
//

import SwiftUI

struct SearchView: View {
    @State var search = ""
    @State var showFilterView = false
    @State var searchFilter = SearchFilter()
    @StateObject var vm: SearchViewModel = SearchViewModel()
    var filteredVerses: [FullTextResult.Vers] {
        return vm.fullResult.verses
    }
    var body: some View {
        VStack(spacing: 0) {
            header
                .padding(.bottom)
            VStack {
                SearchField(text: $search, onCommit: {}, onClear: {}, onCancel: {})
                    .padding(.horizontal)
                
                FilterView(count: 0, showFilterView: $showFilterView, searchFilter: $searchFilter)
                    .padding(.horizontal)
                versList
            }

            
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
                
                Text(vers.text)
                    .lineLimit(3)
                    .lineSpacing(4)
            }
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var searchVM: SearchViewModel {
        let vm = SearchViewModel()
        vm.fullResult = try! Util.getSZISearch(filename: "result_sample").fullTextResult
        return vm
    }
    static var previews: some View {
        SearchView(vm: searchVM)
    }
}
