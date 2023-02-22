//
//  Extensions.swift
//  Szentiras_v4
//
//  Created by Gabor Sornyei on 2023. 01. 01..
//

import SwiftUI

extension Color {
    static var darkGreen: Color {
        Color("darkGreen")
    }
    
    static var bgGray: Color {
        Color("bgGray")
    }

    static var textGray: Color {
        Color("textGray")
    }
}



extension String {
    var html: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}


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
}
