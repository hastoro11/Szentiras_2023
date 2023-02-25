//
//  VersRow.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 25..
//

import SwiftUI

struct VersRow: View {
    var index: Int
    var text: String
    var body: some View {
        VStack {
            Text("\(index)  ")
                .foregroundColor(.darkGreen)
                .fontWeight(.heavy) +
            Text(text.html)
                .fontWeight(.light)
        }
        .lineSpacing(4)
    }
}

struct VersRow_Previews: PreviewProvider {
    static var previews: some View {
        VersRow(index: 1, text: "Előbb az üldözők és kínzók akik félreismerték a szolgát (1-6), majd a próféta (7-10) elmélkednek a szolga sorsáról. Végül maga Isten szól a szolga jövőjéről (11-12). Egy igaz szenvedése sokakat igazzá tett, mert Isten elfogadta őt engesztelő áldozatul.")
    }
}
