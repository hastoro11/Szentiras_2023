//
//  View+Extensions.swift
//  Szentiras
//
//  Created by Gabor Sornyei on 2023. 03. 07..
//

import SwiftUI



extension View {
    func showError(isPresented: Binding<Bool>, error: APIError?, guidance: String, backAction: @escaping () -> Void, againAction: @escaping () -> Void) -> some View {
        Group {
            if let error = error {
                ZStack {
                    self.redacted(reason: isPresented.wrappedValue ? .placeholder : [])
                    ErrorAlertView(errorWrapper: ErrorWrapper(error: error, guidance: guidance), backAction: backAction, againAction: againAction)
                }
            } else {
                self
            }
        }
    }
    
    func isLoading(_ loading: Binding<Bool>) -> some View {
        Group {
            if loading.wrappedValue {
                ZStack {
                    self
                        .redacted(reason: loading.wrappedValue ? .placeholder : [])
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Material.thick)
                        .frame(width: 100, height: 100)
                    ProgressView {
                        Text("Keresés...")
                    }
                }
            } else {
                self
            }
        }
    }
    
    func animateLetter(animate: Binding<Bool>, delay: Double, duration: Double) -> some View {
        self
            .modifier(AnimateLetter(animate: animate, duration: duration, delay: delay))
    }
}

struct AnimateLetter: ViewModifier {
    @Binding var animate: Bool
    var duration: Double
    var delay: Double
    func body(content: Content) -> some View {
        content
        .offset(y: animate ? -15 : 0)
        .animation(.easeInOut(duration: duration).delay(delay), value: animate)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+duration) {
                animate = false
            }
        }
    }
}
