//
//  CustomErrorView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 14/02/24.
//

import SwiftUI

struct CustomErrorView: View {
    
    let action: () async -> Void
    let secondsToRetry: String
    
    var body: some View {
        VStack {
            Text("Oops! Something went wrong.")
                .font(.title)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                Task {
                    await action()
                }
            }) {
                Text("Retry after \(secondsToRetry) seconds")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
            }
            .padding()
        }
    }
}
