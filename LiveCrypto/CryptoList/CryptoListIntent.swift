//
//  CryptoListIntent.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 10/02/24.
//

import Foundation

enum CryptoListIntent {
    case loading
    case fetched([CryptoListResponse])
    case apiError
}
