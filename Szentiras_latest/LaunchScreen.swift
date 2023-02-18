//
//  LaunchScreen.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("SZENTÍRÁS")
                    .font(.system(size: 48))
                    .fontWeight(.heavy)
                .foregroundColor(.white)
                Image("bible")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                Spacer()
                Spacer()
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
