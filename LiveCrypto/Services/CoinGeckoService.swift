//
//  CoinGeckoService.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 07/02/24.
//

import Foundation

protocol CoinGeckoServiceProtocol{
    func fetchCryptoList() async -> Result<[CryptoListResponse], Error>
    func fetchCryptoDetails(coinId: String) async -> Result<CryptoDetailsResponse, Error>
    func fetchCryptoHistorycal(coinId: String) async -> Result<[CryptoHistorycalResponse], Error>
}

struct CoinGeckoService:  CoinGeckoServiceProtocol {
    let baseURL = "https://api.coingecko.com/api/v3"
    let apiKey = "CG-p5XCEzZ9hFEoyxS9AoLDfomw"

    func fetchCryptoList() async -> Result<[CryptoListResponse], Error> {

        guard let url = URL(string: "\(baseURL)/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h") else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x_cg_demo_api_key")
        
        return await withCheckedContinuation { continuation in
            
            // Create a URLSession data task to fetch data from the API
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Check for errors and response status
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print(response ?? "Error")
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                // Decode the JSON response into an array of Crypto objects
                do {
                    let response = try JSONDecoder().decode([CryptoListResponse].self, from: data)
                    print(response)
                    return continuation.resume(returning: .success(response))
                } catch {
                    print("Error decoding JSON:", error)
                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
    
    func fetchCryptoDetails(coinId: String) async -> Result<CryptoDetailsResponse, Error> {
        guard let url = URL(string: "\(baseURL)/coins/\(coinId)?localization=en&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=true") else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x_cg_demo_api_key")
        
        return await withCheckedContinuation { continuation in
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                do {
                    let response = try JSONDecoder().decode(CryptoDetailsResponse.self, from: data)
                    return continuation.resume(returning: .success(response))
                } catch {
                    print("Error decoding JSON:", error)

                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
    
    func fetchCryptoHistorycal(coinId: String) async -> Result<[CryptoHistorycalResponse], Error> {
        guard let url = URL(string: "\(baseURL)/coins/\(coinId)/ohlc?vs_currency=eur&days=7") else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "x_cg_demo_api_key")
        
        return await withCheckedContinuation { continuation in
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                do {
                    let response = try JSONDecoder().decode([[Double]].self, from: data)
                    
                    let marketData = response.map { entry in
                        CryptoHistorycalResponse(timestamp: entry[0] / 1000, open: entry[1], high: entry[2], low: entry[3], close: entry[4])
                    }
                    print(marketData)
                    return continuation.resume(returning: .success(marketData))
                } catch {
                    print("Error decoding JSON:", error)
                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
}
