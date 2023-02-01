//
//  AcronymViewModelTests.swift
//  AcronymCodeChallenge1Tests
//
//  Created by admin on 30/01/2023.
//

import XCTest
@testable import AcronymCodeChallenge1

final class AcronymViewModelTests: XCTestCase {
    
    var viewModel: AcronymViewModel!
    var fakeRepository: AcronymListRepositoryImplementation!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeRepository = AcronymListRepositoryImplementation(networkManager: FakeNetworkManager())
        self.viewModel = AcronymViewModel(repository: fakeRepository)
        
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        try super.tearDownWithError()
    }
    
    func testSearchAcronymSuccess() {
        let expectation = XCTestExpectation(description: "Notify Success Binding")
        
        self.viewModel.bind {
            expectation.fulfill()
        } failureBinding: { err in
            print(err)
        }

        XCTAssertEqual(self.viewModel.count, 0)
        XCTAssertNil(self.viewModel.fullForm(for: 0))
        self.viewModel.searchAcronym(acronym: "test")
        
        XCTAssertEqual(self.viewModel.count, 0)
        XCTAssertNil(self.viewModel.fullForm(for: 0), "Department of Energy")
    }
    
    func testSearchAcronymEmptyResultFailure() {
        let expectation = XCTestExpectation(description: "Notify Failure Binding with Empty Result")
        var networkError: NetworkError?
        
        self.viewModel.bind {
            XCTFail()
        } failureBinding: { error in
            networkError = error as? NetworkError
            expectation.fulfill()
        }
        self.viewModel.searchAcronym(acronym: NetworkError.emptyResult.urlTest)
        wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(networkError, NetworkError.emptyResult)
    }
    
    func testSearchAcronymMissingDataFailure() {
        let expectation = XCTestExpectation(description: "Notify Failure Binding With Missing Data")
        var networkError: NetworkError?
        self.viewModel.bind {
            XCTFail()
        } failureBinding: { error in
            networkError = error as? NetworkError
            expectation.fulfill()
        }
        self.viewModel.searchAcronym(acronym: NetworkError.missingData.urlTest)
        wait(for: [expectation], timeout: 3)
        XCTAssertEqual(networkError, NetworkError.missingData)
    }
    
    func testSearchAcronymWithEmptyQuery() {
        self.viewModel.searchAcronym(acronym: "")
        XCTAssertEqual(self.viewModel.count, 0)
    }

}
