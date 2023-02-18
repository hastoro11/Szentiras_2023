//
//  ErrorWrapper.swift
//  NetworkTest
//
//  Created by Gabor Sornyei on 2023. 01. 22..
//

import SwiftUI

struct ErrorWrapper: Identifiable {
    var id: String = UUID().uuidString
    var error: Error
    var guidance: String
    
    init(error: Error, guidance: String) {
        self.error = error
        self.guidance = guidance
    }
}

struct ErrorAlertView: View {
    var errorWrapper: ErrorWrapper
    var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .fill(.thinMaterial)
                .frame(width: 300, height: 200)
                .overlay(alignment: .top) {
                    VStack(spacing: 0) {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.red)
                            .font(.largeTitle)
                            .padding(8)
                        Text(errorWrapper.error.localizedDescription)
                            .font(.title2)
                        Text(errorWrapper.guidance)
                            .padding(10)
                        Spacer()
                        Divider()
                        HStack {
                            Button("Cancel") {}
                                .frame(width: 150)
                            Divider()
                            Button("Try again") {}
                                .frame(width: 150)
                        }
                        .frame(height: 55)
                        .font(.title3)
    //                    .padding()
                    }
            }

    }
}

struct ErrorView: View {
    var errorWrapper: ErrorWrapper
    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}


struct Previews_ErrorWrapper_Previews: PreviewProvider {
    static var errorWrapper = ErrorWrapper(error: NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Wrong URL"]), guidance: "Something happened")
    
    static var previews: some View {
        ErrorAlertView(errorWrapper: errorWrapper)
//        ErrorView(errorWrapper: errorWrapper)
    }
}
