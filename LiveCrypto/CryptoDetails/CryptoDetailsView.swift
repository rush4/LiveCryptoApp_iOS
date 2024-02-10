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
                
                
                
                switch viewModel.cryptoDetailsntent {
                    
                case .loading:
                    ProgressView().onAppear(perform: {
                        viewModel.fetchDetails(cryptoId ?? "")
                    })
                case .fetchedCryptoDetails(let details, let historycal):
                    
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
                        Text(details?.name ?? "")
                    }
                    Text("Description")
                        .font(.headline)
                    Text(details?.description.en ?? "")
                        .font(.body)
                    
                    Divider()
                    
                    let website = viewModel.cryptoDetails?.links.homepage.first ?? ""
                    
                    Link(website , destination: (URL(string: website) ?? URL(string: "www.mooney.it"))!)
                        .font(.body)
                    
                    Divider()
                    
                    Text(String(viewModel.cryptoHistorycal.first?.close ?? 0000) )
                        .font(.headline)
                    
                        .padding()
                        .navigationBarTitle(viewModel.cryptoDetails?.name ?? "")
                    
                case .apiError(let error):
                    Text(error)
                        .foregroundColor(Color.red)
                        .padding(.all)
                case .none:
                    Text("Error")
                        .foregroundColor(Color.red)
                        .padding(.all)
                }
            }
        }
    }
}

#Preview {
    CryptoDetailsView(cryptoId: "bitcoin")
}
