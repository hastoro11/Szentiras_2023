//
//  FilterView.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 21..
//

import SwiftUI

struct SearchFilter: Equatable {
    enum Testament: String, CaseIterable {
        case none = ""
        case oldTestament = "Ószövetség"
        case newTestament = "Újszövetség"
    }
    var book: Int = 0
    var testament: Testament = .none
    var translation: Int = 0
}

struct FilterView: View {
    var count: Int
    @Binding var showFilterView: Bool
    @Binding var searchFilter: SearchFilter
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(count) találat")
            }
            Picker(selection: $searchFilter.translation) {
                Text("Mind").tag(0)
                ForEach(Translation.allCases) { tr in
                    Text(tr.rawValue).tag(tr.id)
                }
                
            } label: {
                Text("")
            }
            .pickerStyle(.segmented)
            Picker("", selection: $searchFilter.testament) {
                Text("Mind").tag(SearchFilter.Testament.none)
                Text("Ószöv").tag(SearchFilter.Testament.oldTestament)
                Text("Újszöv").tag(SearchFilter.Testament.newTestament)
            }
            .pickerStyle(.segmented)
            
            HStack {
                Text("Könyvek")
                    
                Spacer()
                Picker("", selection: $searchFilter.book) {
                    Text("Mind")
                        .tag(0)
                    ForEach(Book.combined) { book in
                        Text(book.name)
                            .tag(book.number)
                        
                    }
                }
                .pickerStyle(MenuPickerStyle.menu)
            }
            .padding(.bottom)
        }
        .tint(.darkGreen)
    }
}

struct Fe_lterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(count: 0, showFilterView: .constant(true), searchFilter: .constant(SearchFilter()))
    }
}
