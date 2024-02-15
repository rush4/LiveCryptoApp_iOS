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
                VStack(){
                    Text("Markets")
                        .font(.custom("HelveticaNeue-Bold", size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                    List(cryptos, id: \.id) { crypto in
                        
                        Button(action: {
                            viewmodel.cryptoSelected(crypto.id)
                        }) {
                            CryptoRowView(crypto: crypto)
                        }
                    }.refreshable {
                        await viewModel.fetchTopCryptos()
                    }
                }
            }
        case .apiError(let error):
            
            if error.code == 429 {
                
                let secondsToRetry = error.userInfo["NSLocalizedDescription"] as? String ?? ""
                CustomErrorView(action: viewModel.fetchTopCryptos, secondsToRetry: secondsToRetry)
            }
        }
    }
}

#Preview {
    CryptoListView(viewModel: CryptoListViewModel())
}
