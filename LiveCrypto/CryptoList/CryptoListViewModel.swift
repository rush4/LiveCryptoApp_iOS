import Foundation
import UIKit

class CryptoListViewModel: ObservableObject {
    
    // Published property to hold the current state of the list intent
    @Published var listIntent: CryptoListIntent = .loading
    
    // Closure to handle navigation to crypto details
    var goToCryptoDetailsClosure: ((_ cryptoId: String) -> Void)?
    
    // Service object to fetch crypto data
    var service: CoinGeckoServiceProtocol? = nil
    
    // Initialization
    init() {
        // Resolve the CoinGecko service dependency
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let coinGeckoService = appDelegate.container.resolve(type: CoinGeckoServiceProtocol.self)  else {
            // Assert if unable to resolve the service
            assert(false, "impossibile risolvere CoinGeckoServiceProtocol")
            return
        }
        service = coinGeckoService
    }
    
    // Function to fetch top cryptocurrencies asynchronously
    func fetchTopCryptos() async {
        
        let result = await self.service?.fetchCryptoList()
        
        switch result {
        case .success(let response):
            // Update the list intent with fetched data
            self.listIntent = .fetched(response)
            
        case .failure(let error):
            // Update the list intent with API error
            self.listIntent = .apiError(error as NSError)
        case .none:
            // Update the list intent with a simple error if no response
            let simpleError = NSError(domain: "", code: 404)
            self.listIntent = .apiError(simpleError)
        }
    }
    
    // Function to handle selection of a cryptocurrency
    func cryptoSelected(_ cryptoId: String) {
        // Invoke closure to navigate to crypto details with the selected crypto ID
        goToCryptoDetailsClosure?(cryptoId)
    }
}
