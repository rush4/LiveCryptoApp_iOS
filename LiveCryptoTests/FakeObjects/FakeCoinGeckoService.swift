//
//  FakeCoinGeckoService.swift
//  LiveCryptoTests
//
//  Created by Salvatore Raso on 15/02/24.
//

@testable import LiveCrypto

class FakeCoinGeckoService: CoinGeckoServiceProtocol {
    func fetchCryptoList() async -> Result<[LiveCrypto.CryptoListResponse], Error> {
        .success(FakeResponses().buildCryptoListResponse())
    }
    
    func fetchCryptoDetails(coinId: String) async -> Result<LiveCrypto.CryptoDetailsResponse, Error> {
        .success(FakeResponses().buildCryptoDetail())
    }
    
    func fetchCryptoHistorycal(coinId: String) async -> Result<[LiveCrypto.CryptoHistorycalResponse], Error> {
        .success(FakeResponses().buildCryptoHistorycal())
    }
}
