//
//  ChapterHeader.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 25..
//

import SwiftUI

struct ChapterHeader: View {
    var book: String
    var chapter: Int
    var body: some View {
        VStack(alignment: .leading) {
            Text(book)
                .font(.system(.largeTitle, design: .default, weight: .bold))
            Text("\(chapter). fejezet")
                .font(.system(.title3, design: .serif, weight: .light))
                .italic()
                .foregroundColor(Color(.systemGray))
        }
    }
}

struct ChapterHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChapterHeader(book: "Teremtés könyve", chapter: 1)
    }
}
