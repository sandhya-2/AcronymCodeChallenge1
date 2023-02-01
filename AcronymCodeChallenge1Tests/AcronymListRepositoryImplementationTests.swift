//
//  AcronymListRepositoryImplementationTests.swift
//  AcronymCodeChallenge1Tests
//
//  Created by admin on 31/01/2023.
//

import XCTest
@testable import AcronymCodeChallenge1

final class AcronymListRepositoryImplementationTests: XCTestCase {
    
    var networkManager: FakeNetworkManager!
    var respository = AcronymListRepositoryImplementation(networkManager: FakeNetworkManager())
    
        
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = FakeNetworkManager()
        
    }
    
    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
        
    }
    
    func testgetAcronyms() {
        let expectation = XCTestExpectation(description: "Successfully got and decoded data")
        
        let acronym: String = "DOE"
        var acronymText: [Acronym]!
        
        respository.getAcronyms(acronym: acronym) { [acronym] result in
            switch result {
            case .success(let result):
                if let value = result.first {
                    // true success
                    print(value)
                    expectation.fulfill()
                } else {
                    
                    XCTFail()
                }
            case .failure(let error):
                print(error.localizedDescription)
                XCTFail()
            }
           

           XCTAssertEqual(acronym, "Department of Energy")
           XCTAssertEqual(acronymText?.first?.lfs.count, 6)
        }
    }
}
