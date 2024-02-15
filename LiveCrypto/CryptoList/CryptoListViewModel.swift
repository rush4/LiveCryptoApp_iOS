//
//  CryptoListViewModel.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import Foundation
import UIKit

class CryptoListViewModel: ObservableObject {
    
    @Published var listIntent: CryptoListIntent = .loading
    
    var goToCryptoDetailsClosure: ((_ cryptoId: String) -> Void)?
    var service: CoinGeckoServiceProtocol? = nil
    
    init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let coinGeckoService = appDelegate.container.resolve(type: CoinGeckoServiceProtocol.self)  else {
            assert(false, "impossibile risolvere CoinGeckoServiceProtocol")
            return
        }
        service = coinGeckoService
    }
    
    func fetchTopCryptos() async {
        
        let result = await self.service?.fetchCryptoList()
        
        switch result {
        case .success(let response):
            self.listIntent = .fetched(response)
            
        case .failure(let error):
            self.listIntent = .apiError(error as NSError)
        case .none:
            let simpleError = NSError(domain: "", code: 404)
            self.listIntent = .apiError(simpleError)
        }
    }
    
    func cryptoSelected(_ cryptoId: String) {
        goToCryptoDetailsClosure?(cryptoId)
    }
}
