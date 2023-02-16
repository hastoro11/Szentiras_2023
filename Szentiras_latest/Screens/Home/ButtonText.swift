//
//  ButtonText.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 16..
//

import SwiftUI

struct ButtonText: View {
    var text: String
    var selected: Bool

    
    init(_ text: String, selected: Bool = false) {
        self.text = text
        self.selected = selected
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(selected ? .white : .black)
            .font(.body)
            .fontWeight(.heavy)
            .frame(width: 55, height: 45)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(selected ? Color.darkGreen :Color(.systemGray5))
            }
    }
}

struct ButtonText_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ButtonText("150")
                .previewLayout(.sizeThatFits)
            .padding()
            
            ButtonText("55", selected: true)
                .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
