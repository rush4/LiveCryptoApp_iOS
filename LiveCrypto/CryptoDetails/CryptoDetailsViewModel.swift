//
//  CryptoDetailsViewModel.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import Foundation

class CryptoDetailsViewModel: ObservableObject {
    @Published var cryptoDetails: CryptoDetailsResponse?
    @Published var cryptoHistorycal: [CryptoHistorycalResponse] = []
        
    var intent: CryptoDetailsIntent?
    
    let service: CoinGeckoServiceProtocol = CoinGeckoService()
    
    func getCryptoDetails(for cryptoId: String) async {
        
        let result = await service.fetchCryptoDetails(coinId: cryptoId)
        switch result {
        case .success(let response):
            // Handle successful response
            DispatchQueue.main.async {
                self.cryptoDetails = response
            }
        case .failure(let error):
            // Handle error
            print("Error fetching crypto details: \(error)")
        }
    }
    
    func fetchCryptoHistorycal(for cryptoId: String) async {
        
        let result = await self.service.fetchCryptoHistorycal(coinId: cryptoId)
        
        switch result {
        case .success(let response):
            DispatchQueue.main.async {
                self.cryptoHistorycal = response
            }
            
            
            print(response)
        case .failure(let error):
            // Handle error
            print("Error fetching crypto details: \(error)")
        }
    }
    
    func getCryptoDetails1(for cryptoId: String) {
        
        service.fetchCryptoDetails1(coinId: cryptoId) { result in
            
            switch result {
            case .success(let response):
                // Handle successful response
                DispatchQueue.main.async {
                    self.cryptoDetails = response
                }
            case .failure(let error):
                // Handle error
                print("Error fetching crypto details: \(error)")
            }
        }
    }
}
