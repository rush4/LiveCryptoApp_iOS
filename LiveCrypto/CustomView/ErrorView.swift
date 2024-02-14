//
//  ErrorView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 14/02/24.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        Text("API Error")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.red)
            .padding(.all)
    }
}

#Preview {
    ErrorView()
}
