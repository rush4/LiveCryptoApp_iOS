//
//  CryptoListResponse.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 07/02/24.
//

import Foundation

struct CryptoListResponse: Decodable {
    var id: String
    let symbol: String
    let name: String
    let image: String?
    let currentPrice: Double?
//    let marketCap: Int?
//    let marketCapRank: Int?
//    let fullyDilutedValuation: Int?
//    let totalVolume: Int?
//    let high24h: Double?
//    let low24h: Double?
//    let priceChange24h: Double?
//    let priceChangePercentage24h: Float?
//    let marketCapChange24h: Int?
//    let marketCapChangePercentage24h: Double?
//    let circulatingSupply: Double?
//    let totalSupply: Double?
//    let maxSupply: Double?
//    let ath: Double?
//    let athChangePercentage: Double?
//    let athDate: String?
//    let atl: Double?
//    let atlChangePercentage: Double?
//    let atlDate: String?
//    let roi: ROI?
//    let lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case image = "image"
        case currentPrice = "current_price"
//        case marketCap = "market_cap"
//        case marketCapRank = "market_cap_rank"
//        case fullyDilutedValuation = "fully_diluted_valuation"
//        case totalVolume = "total_volume"
//        case high24h = "high_24h"
//        case low24h = "low_24h"
//        case priceChange24h = "price_change_24h"
//        case priceChangePercentage24h = "price_change_percentage_24h"
//        case marketCapChange24h = "market_cap_change_24h"
//        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
//        case circulatingSupply = "circulating_supply"
//        case totalSupply = "total_supply"
//        case maxSupply = "max_supply"
//        case ath, athChangePercentage = "ath_change_percentage"
//        case athDate = "ath_date"
//        case atl, atlChangePercentage = "atl_change_percentage"
//        case atlDate = "atl_date"
//        case roi
//        case lastUpdated = "last_updated"
    }
}

struct ROI: Codable {
    let times: Double
    let currency: String
    let percentage: Double
}
