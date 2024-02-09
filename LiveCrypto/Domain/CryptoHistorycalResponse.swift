//
//  CryptoHistorycalResponse.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import Foundation

struct CryptoHistorycalResponse: Codable {
    
    let timestamp: TimeInterval
    let open: Double
    let high: Double
    let low: Double
    let close: Double
}
