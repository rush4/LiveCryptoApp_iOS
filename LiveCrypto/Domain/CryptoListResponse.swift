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
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case image = "image"
        case currentPrice = "current_price"
    }
}
