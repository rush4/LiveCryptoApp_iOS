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
    func fetchCryptoDetails1(coinId: String, completion: @escaping (Result<CryptoDetailsResponse, Error>) -> Void)
}

struct CoinGeckoService:  CoinGeckoServiceProtocol {
    let baseURL = "https://api.coingecko.com/api/v3"

    func fetchCryptoList() async -> Result<[CryptoListResponse], Error> {
        // Define the URL for the API endpoint
        guard let url = URL(string: "\(baseURL)/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=it") else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        return await withCheckedContinuation { continuation in
            
            // Create a URLSession data task to fetch data from the API
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Check for errors and response status
                guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print(response ?? "Error")
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                // Decode the JSON response into an array of Crypto objects
                do {
                    let decoder = JSONDecoder()
                    decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
                    
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
        guard let url = URL(string: "\(baseURL)/coins/\(coinId)") else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
        return await withCheckedContinuation { continuation in
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return continuation.resume(returning: .failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                }
                
                do {
                    let response = try JSONDecoder().decode(CryptoDetailsResponse.self, from: data)
                    return continuation.resume(returning: .success(response))
                } catch {
                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
    
    func fetchCryptoHistorycal(coinId: String) async -> Result<[CryptoHistorycalResponse], Error> {
        guard let url = URL(string: "\(baseURL)/coins/\(coinId)/ohlc?vs_currency=eur&days=7") else {
            return (.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }
        
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
                    
                    return continuation.resume(returning: .success(marketData))
                } catch {
                    return continuation.resume(returning: .failure(error))
                }
            }.resume()
        }
    }
    
    func fetchCryptoDetails1(coinId: String, completion: @escaping (Result<CryptoDetailsResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/coins/\(coinId)") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
                    
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                                completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])))
                                return
                            }
                
                do {
                    let response = try JSONDecoder().decode(CryptoDetailsResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
    }
}
