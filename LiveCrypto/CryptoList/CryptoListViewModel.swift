//
//  CryptoListViewModel.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import Foundation

class CryptoListViewModel: ObservableObject {
    
    @Published var listIntent: CryptoListIntent = .loading
    
    var goToCryptoDetailsClosure: ((_ cryptoId: String) -> Void)?
    let service: CoinGeckoServiceProtocol = CoinGeckoService()
    
    func fetchTopCryptos() async {
        
        let result = await self.service.fetchCryptoList()
        
        switch result {
        case .success(let response):
            self.listIntent = .fetched(response)
            
        case .failure(let error):
            self.listIntent = .apiError
        }
    }
    
    func cryptoSelected(_ cryptoId: String) {
        goToCryptoDetailsClosure?(cryptoId)
    }
}
