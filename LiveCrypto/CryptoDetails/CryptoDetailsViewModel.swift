import Foundation
import UIKit

// Enum to represent different types of price charts
enum PricesChartType {
    case bar
    case line
}

// View model for crypto details view
class CryptoDetailsViewModel: ObservableObject {
    
    // Published property to hold the intent of the crypto details view
    @Published var cryptoDetailsntent: CryptoDetailsIntent = .loading
    
    // Property to hold the service responsible for fetching data
    var service: CoinGeckoServiceProtocol? = nil
    
    // Initialize the view model
    init() {
        // Resolve the CoinGecko service from the dependency container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let coinGeckoService = appDelegate.container.resolve(type: CoinGeckoServiceProtocol.self)  else {
            assert(false, "impossible to resolve CoinGeckoServiceProtocol")
            return
        }
        service = coinGeckoService
    }
    
    // Function to fetch crypto details and historical data
    func fetchDetails(_ cryptoId: String) {
        Task {
            // Fetch crypto details and historical data asynchronously
            async let cryptoDetails = getCryptoDetails(for: cryptoId)
            async let historicalDetails = fetchCryptoHistorycal(for: cryptoId)
            
            // Update the intent with fetched details
            cryptoDetailsntent = await .fetchedCryptoDetails(cryptoDetails, historicalDetails)
        }
    }
    
    // Function to fetch crypto details
    func getCryptoDetails(for cryptoId: String) async -> CryptoDetailsResponse? {
        let result = await service?.fetchCryptoDetails(coinId: cryptoId)
        switch result {
        case .success(let response):
            // Return fetched details on success
            return response
        case .failure(let error):
            // Print error on failure and return nil
            print("Error fetching crypto details: \(error)")
            return nil
        case .none:
            // Return nil if no result
            return nil
        }
    }
    
    // Function to fetch crypto historical data
    func fetchCryptoHistorycal(for cryptoId: String) async -> [CryptoHistorycalResponse]? {
        let result = await self.service?.fetchCryptoHistorycal(coinId: cryptoId)
        switch result {
        case .success(let response):
            // Return fetched historical data on success
            return response
        case .failure(let error):
            // Print error on failure and return nil
            print("Error fetching crypto historycal data: \(error)")
            return nil
        case .none:
            // Return nil if no result
            return nil
        }
    }
}
