//
//  CryptoListView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 07/02/24.
//

import SwiftUI

enum CryptoListIntent {
    case loading
    case fetched([CryptoListResponse])
    case apiError(String)
}

protocol CryptoDetailsIntent {
    func fetchHistoricalPrices(for cryptoId: String)
}

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
                        viewmodel.goToCryptoDetailsClosure?(crypto.id)
                    }) {
                        CryptoRowView(crypto: crypto)
                    }
                }
            }
        case .apiError(let error):
            Text(error)
                .foregroundColor(Color.red)
                .padding(.all)
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
                .frame(width: 40, height: 40) // Adjust size as needed
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
