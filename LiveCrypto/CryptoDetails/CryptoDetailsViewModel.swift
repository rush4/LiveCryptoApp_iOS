//
//  CryptoDetailsViewModel.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import Foundation

protocol CryptoDetailsIntentProtocol {
    func fetchHistoricalPrices(for cryptoId: String)
}

class CryptoDetailsViewModel: ObservableObject {
    @Published var cryptoDetails: CryptoDetailsResponse?
    @Published var cryptoHistorycal: [CryptoHistorycalResponse] = []
        
    var cryptoDetailsntent: CryptoDetailsIntent?
    let service: CoinGeckoServiceProtocol = CoinGeckoService()
    
    func fetchDetails(_ cryptoId: String) {
        
        Task {
            
            async let cryptoDetails = getCryptoDetails(for:cryptoId)
            async let historicalDetails = fetchCryptoHistorycal(for: cryptoId)
            
            let responses = await [cryptoDetails, historicalDetails]
            
           cryptoDetailsntent = await .fetchedCryptoDetails(cryptoDetails, historicalDetails)
        }
        
    }
    
    func getCryptoDetails(for cryptoId: String) async -> (CryptoDetailsResponse?){
        
        let result = await service.fetchCryptoDetails(coinId: cryptoId)
        switch result {
        case .success(let response):
            
            return (response)

        case .failure(let error):

            print("Error fetching crypto details: \(error)")
            return(nil)
        }
    }
    
    func fetchCryptoHistorycal(for cryptoId: String) async -> ([CryptoHistorycalResponse]?){
        
        let result = await self.service.fetchCryptoHistorycal(coinId: cryptoId)
        
        switch result {
        case .success(let response):
            
            return (response)

        case .failure(let error):

            print("Error fetching crypto details: \(error)")
            return(nil)
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
