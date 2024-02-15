//
//  FakeCore.swift
//  LiveCryptoTests
//
//  Created by Salvatore Raso on 15/02/24.
//

@testable import LiveCrypto

class FakeCore: BaseCore {
    
    /// Dependencies container
    let container: Container
    
    lazy var coinGeckoService: CoinGeckoServiceProtocol = FakeCoinGeckoService()
    
    init(container: Container) {
        self.container = container
    }
}
