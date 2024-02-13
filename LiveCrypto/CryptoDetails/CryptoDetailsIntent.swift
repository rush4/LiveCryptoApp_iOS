//
//  CryptoDetailsIntent.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 10/02/24.
//

import Foundation

enum CryptoDetailsIntent {
    case loading
    case fetchedCryptoDetails(CryptoDetailsResponse?,[CryptoHistorycalResponse]?)
}
