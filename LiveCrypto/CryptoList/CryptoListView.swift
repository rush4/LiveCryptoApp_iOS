//
//  CryptoListView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 07/02/24.
//

import SwiftUI

struct CryptoListView: View {
    @ObservedObject var viewModel: CryptoListViewModel
    
    var body: some View {
        
        let viewmodel = self.viewModel
        
        switch viewModel.listIntent {
        case .loading:
            ProgressView().onAppear {
                Task{
                    await viewmodel.fetchTopCryptos()
                }
            }
        case .fetched(let cryptos):
            
            if cryptos.isEmpty {
                Text("No Results found")
                    .foregroundColor(Color.red)
                    .padding(.all)
            } else {
                List(cryptos, id: \.id) { crypto in
                    
                    Button(action: {
                        viewmodel.cryptoSelected(crypto.id)
                    }) {
                        CryptoRowView(crypto: crypto)
                    }
                }
            }
        case .apiError:
            Button(action: {
                Task{
                    await viewmodel.fetchTopCryptos()
                }
            }) {
                Text("Retry after 60 seconds")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
            }
        }
    }
}

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
                Text("Invalid URL")
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

#Preview {
    CryptoListView(viewModel: CryptoListViewModel())
}
