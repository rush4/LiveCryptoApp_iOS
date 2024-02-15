//
//  CryptoHistorycalResponse.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 08/02/24.
//

import Foundation

enum CryptoHistorycalPriceTypes: String, CaseIterable {
    
    case low = "Low"
    case close = "Close"
    case high = "High"
}

struct CryptoHistorycalResponse: Codable, Identifiable {
    
    let timestamp: TimeInterval
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    
    
    var id: Date {
      return Date(timeIntervalSince1970: timestamp)
    }

    func temp(type: CryptoHistorycalPriceTypes) -> Double {
      switch type {
      case .low:
        return self.low
      case .high:
        return self.high
      case .close:
        return self.close
      }
    }
}
