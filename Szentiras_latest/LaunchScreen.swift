//
//  LaunchScreen.swift
//  Szentiras_latest
//
//  Created by Gabor Sornyei on 2023. 02. 18..
//

import SwiftUI

struct LaunchScreen: View {
    @State var animate: Bool = false
    var duration: Double = 0.5
    var delay: Double = 0.125
    var body: some View {
        ZStack {
            Color.darkGreen
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    Text("S")
                        .animateLetter(animate: $animate, delay: delay*0, duration: duration)
                    Text("Z")
                        .animateLetter(animate: $animate, delay: delay*1, duration: duration)
                    Text("E")
                        .animateLetter(animate: $animate, delay: delay*2, duration: duration)
                    Text("N")
                        .animateLetter(animate: $animate, delay: delay*3, duration: duration)
                    Text("T")
                        .animateLetter(animate: $animate, delay: delay*4, duration: duration)
                    Text("Í")
                        .animateLetter(animate: $animate, delay: delay*5, duration: duration)
                    Text("R")
                        .animateLetter(animate: $animate, delay: delay*6, duration: duration)
                    Text("Á")
                        .animateLetter(animate: $animate, delay: delay*7, duration: duration)
                    Text("S")
                        .animateLetter(animate: $animate, delay: delay*8, duration: duration)
                    
                }
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
            .onAppear {
                animate = true
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
