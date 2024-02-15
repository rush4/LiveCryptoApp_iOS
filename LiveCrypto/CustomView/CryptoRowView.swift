//
//  CryptoRowView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 15/02/24.
//

import SwiftUI

struct CryptoRowView: View {
    let crypto: CryptoListResponse
    
    var body: some View {
        HStack {
            if let url = URL(string: crypto.image ?? "") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 40, height: 40)
            } else {
                SimpleErrorView()
            }
            Text(crypto.name)
                .foregroundColor(Color.indigo)
                .font(.callout)
            Spacer()
            Text("\(String(crypto.currentPrice ?? 0)) €")
                .font(.callout)
                .foregroundColor(Color.indigo)
        }
    }
}
