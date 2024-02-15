//
//  SimpleErrorView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 15/02/24.
//

import SwiftUI

struct SimpleErrorView: View {
    var body: some View {
        Text("Oops! Something went wrong.")
            .font(.title)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    SimpleErrorView()
}
