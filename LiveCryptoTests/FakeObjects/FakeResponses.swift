//
//  FakeResponses.swift
//  LiveCryptoTests
//
//  Created by Salvatore Raso on 15/02/24.
//

@testable import LiveCrypto

struct FakeResponses {
    
    func buildCryptoListResponse() -> [CryptoListResponse] {
        
        let firstCrypto = CryptoListResponse(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 48741.0)
        let secondCrypto = CryptoListResponse(id: "ethereum", symbol: "eth", name: "Ethereum", image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1696501628", currentPrice: 2610.12)
        let thirdCrypto = CryptoListResponse(id: "ripple", symbol: "xrp", name: "XRP", image: "https://assets.coingecko.com/coins/images/44/large/xrp-symbol-white-128.png?1696501442", currentPrice: 0.516493)
        
        return [firstCrypto, secondCrypto, thirdCrypto]
    }
    
    func buildCryptoDetail() -> CryptoDetailsResponse {
        
        return CryptoDetailsResponse(symbol: "eth", name: "Ethereum", webSlug: "ethereum", assetPlatformID: nil, platforms: ["": ""], detailPlatforms: ["": LiveCrypto.DetailPlatform(decimalPlace: nil, contractAddress: "")], blockTimeInMinutes: 0, categories: ["FTX Holdings", "Proof of Stake (PoS)", "Multicoin Capital Portfolio", "Smart Contract Platform", "Layer 1 (L1)", "Ethereum Ecosystem"], previewListing: false, publicNotice: nil, additionalNotices: [], description: LiveCrypto.Description(en: "Ethereum is a global, open-source platform for decentralized applications. In other words, the vision is to create a world computer that anyone can build applications in a decentralized manner; while all states and data are distributed and publicly accessible. Ethereum supports smart contracts in which developers can write code in order to program digital value. Examples of decentralized apps (dapps) that are built on Ethereum includes tokens, non-fungible tokens, decentralized finance apps, lending protocol, decentralized exchanges, and much more.\r\n\r\nOn Ethereum, all transactions and smart contract executions require a small fee to be paid. This fee is called Gas. In technical terms, Gas refers to the unit of measure on the amount of computational effort required to execute an operation or a smart contract. The more complex the execution operation is, the more gas is required to fulfill that operation. Gas fees are paid entirely in Ether (ETH), which is the native coin of the blockchain. The price of gas can fluctuate from time to time depending on the network demand."), links: LiveCrypto.Links(homepage: ["https://www.ethereum.org/", "", ""], whitepaper: "", blockchainSite: ["https://etherscan.io/", "https://ethplorer.io/", "https://blockchair.com/ethereum", "https://eth.tokenview.io/", "https://www.oklink.com/eth", "https://3xpl.com/ethereum", "", "", "", ""], officialForumURL: ["", "", ""], chatURL: ["", "", ""], announcementURL: ["", ""], twitterScreenName: "ethereum", facebookUsername: "", bitcointalkThreadIdentifier: nil, telegramChannelIdentifier: "", subredditURL: "https://www.reddit.com/r/ethereum", reposURL: LiveCrypto.ReposURL(github: ["https://github.com/ethereum/go-ethereum", "https://github.com/ethereum/py-evm", "https://github.com/ethereum/aleth", "https://github.com/ethereum/web3.py", "https://github.com/ethereum/solidity", "https://github.com/ethereum/sharding", "https://github.com/ethereum/casper", "https://github.com/paritytech/parity"], bitbucket: [])), image: LiveCrypto.Image(thumb: "https://assets.coingecko.com/coins/images/279/thumb/ethereum.png?1696501628", small: "https://assets.coingecko.com/coins/images/279/small/ethereum.png?1696501628", large: "https://assets.coingecko.com/coins/images/279/large/ethereum.png?1696501628"), countryOrigin: "", sentimentVotesUpPercentage: 92.52, sentimentVotesDownPercentage: 7.48, watchlistPortfolioUsers: 1292662, marketCapRank: 2, statusUpdates: [], lastUpdated: "2024-02-15T11:04:06.770Z")
        
    }
    
    func buildCryptoHistorycal() -> [CryptoHistorycalResponse] {
        
        return [CryptoHistorycalResponse(timestamp: 1707393600.0, open: 41590.0, high: 41590.0, low: 41590.0, close: 41590.0), CryptoHistorycalResponse(timestamp: 1707408000.0, open: 41557.0, high: 41858.0, low: 41509.0, close: 41858.0), CryptoHistorycalResponse(timestamp: 1707422400.0, open: 42212.0, high: 42212.0, low: 41779.0, close: 42025.0), CryptoHistorycalResponse(timestamp: 1707436800.0, open: 42044.0, high: 42205.0, low: 42044.0, close: 42064.0), CryptoHistorycalResponse(timestamp: 1707451200.0, open: 42044.0, high: 42986.0, low: 42044.0, close: 42986.0), CryptoHistorycalResponse(timestamp: 1707465600.0, open: 42775.0, high: 42941.0, low: 42628.0, close: 42878.0)]
    }
}
