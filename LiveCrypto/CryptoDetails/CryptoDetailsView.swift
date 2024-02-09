//
//  CryptoDetailsView.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import SwiftUI

struct CryptoDetailsView: View {
    @ObservedObject var viewModel = CryptoDetailsViewModel()
    let cryptoId: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    if let url = URL(string: viewModel.cryptoDetails?.image.large ?? "") {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView() // Placeholder shown while loading
                        }
                        .frame(width: 60, height: 60) // Adjust size as needed
                    } else {
                        Text("Invalid URL")
                    }
                    Text(viewModel.cryptoDetails?.name ?? "")
                }
                Text("Description")
                    .font(.headline)
                Text(viewModel.cryptoDetails?.description.en ?? "")
                    .font(.body)
                
                Divider()
                
                let website = viewModel.cryptoDetails?.links.homepage.first ?? ""
                
                Link(website , destination: (URL(string: website) ?? URL(string: "www.mooney.it"))!)
                    .font(.body)
                
                Divider()
                
                Text(String(viewModel.cryptoHistorycal.first?.close ?? 0000) )
                    .font(.headline)
                // Representing market prices data as a list
                
//                List {
//                    ForEach(viewModel.cryptoHistorycal.indices, id: \.self) { item in
//                        Text("\(item)")
//                    }
//                }
                
//                CandlestickChartView(candlesticks: viewModel.cryptoHistorycal)
                
                // If you have a chart library, you can integrate it here
            }
            .padding()
            .navigationBarTitle(viewModel.cryptoDetails?.name ?? "")
            .onAppear {
                viewModel.getCryptoDetails1(for: cryptoId ?? "")
//                Task {
//                    
////                    await viewModel.getCryptoDetails(for: cryptoId ?? "")
////                    await viewModel.fetchCryptoHistorycal(for: cryptoId ?? "")
//                }
            }
        }
    }
}

//struct CandlestickChartView: View {
//    let candlesticks: [CryptoHistorycalResponse]
//    
//    var body: some View {
//        VStack {
//            ForEach(candlesticks.indices) { index in
//                CandlestickView(candlestick: candlesticks[index])
//            }
//        }
//    }
//}

#Preview {
    CryptoDetailsView(cryptoId: "bitcoin")
}
