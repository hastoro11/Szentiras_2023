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
    var book: String = ""
    var testament: Testament = .none
    var translation: String = ""
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
                    .font(.headline)
            }
            Picker(selection: $searchFilter.translation) {
                Text("Mind").tag("")
                ForEach(Translation.allCases) { tr in
                    Text(tr.rawValue).tag(tr.rawValue)
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
                    .font(.headline)
                
                Picker("", selection: $searchFilter.book) {
                    Text("Mind")
                        .tag("")
                    ForEach(Book.combined) { book in
                        Text(book.name)
                            .font(.subheadline)
                            .tag(book.number)
                            
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity, alignment: .trailing)
            }            
        }
        .tint(.darkGreen)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        
        FilterView(count: 0, showFilterView: .constant(true), searchFilter: .constant(SearchFilter()))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
