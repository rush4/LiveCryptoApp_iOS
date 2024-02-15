//
//  Core.swift
//  LiveCrypto
//
//  Created by Salvatore Raso on 15/02/24.
//

import Foundation

protocol BaseCore: AnyObject {
    var container: Container { get }
    var coinGeckoService: CoinGeckoServiceProtocol { get }
}

class Core: BaseCore {
    
    /// Dependencies container
    let container: Container
    
    lazy var coinGeckoService: CoinGeckoServiceProtocol = CoinGeckoService()
    
    init(container: Container) {
        self.container = container
    }
}
