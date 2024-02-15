//
//  LiveCryptoTest.swift
//  LiveCryptoTests
//
//  Created by Salvatore Raso on 15/02/24.
//

import XCTest
@testable import LiveCrypto

final class LiveCryptoTest: XCTestCase {
    
    let container: ComponentsContainer = ComponentsContainer()
    lazy var core = FakeCore(container: container)
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testList() async throws {
        let waitingTime = 1.0
        
        // Given
        let expectation = XCTestExpectation(description: "Fetch top cryptos successful")
        
        let listVm = CryptoListViewModel()
        listVm.service = core.coinGeckoService
        
        // When
        await listVm.fetchTopCryptos()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            let response: CryptoListResponse?
            let cryptos = listVm.listIntent
            
            XCTAssertNotNil(listVm.listIntent)
            
            switch listVm.listIntent {
                
            case .fetched(let cryptos):
                
                XCTAssert(cryptos.count == 3)
            case .loading: break
            case .apiError(let error):
                XCTAssertNil(error)
            }
            
            self.wait(for: [expectation], timeout: 2)
            
            let result = XCTWaiter.wait(for: [expectation], timeout: waitingTime + 1.0)
            XCTAssertNotEqual(result, .timedOut)
        }
        
        func testDetails() async throws {
            let waitingTime = 1.0
            
            // Given
            let expectation = XCTestExpectation(description: "Fetch top cryptos successful")
            
            let listVm = CryptoDetailsViewModel()
            listVm.service = core.coinGeckoService
            
            // When
            await listVm.getCryptoDetails(for: "ethereum")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                
                XCTAssertNotNil(listVm.cryptoDetailsntent)
                
                switch listVm.cryptoDetailsntent {
                    
                case .fetchedCryptoDetails(let details, let historycal):
                    
                    XCTAssert(details?.name == "ethereum")
                    
                    XCTAssert(historycal?.count ?? 0 > 3)
                case .loading: break
                }
                
                self.wait(for: [expectation], timeout: 2)
                
                let result = XCTWaiter.wait(for: [expectation], timeout: waitingTime + 1.0)
                XCTAssertNotEqual(result, .timedOut)
            }
            
            func testPerformanceExample() throws {
                // This is an example of a performance test case.
                self.measure {
                    // Put the code you want to measure the time of here.
                }
            }
        }
    }
}
