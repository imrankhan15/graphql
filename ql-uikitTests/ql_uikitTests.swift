//
//  ql_uikitTests.swift
//  ql-uikitTests
//
//  Created by Muhammad Faisal Imran Khan on 2021-12-29.
//  Copyright © 2021 Muhammad Faisal Imran Khan. All rights reserved.
//

import XCTest
@testable import ql_uikit

final class ql_uikitTests: XCTestCase {
    
    /// in this test we find out if our fetch is working or not and if working then if it is in 2 seconds time frame.
    func test_repositoryIsBeingCalled() {
        let repositoryQueryServiceSpy = RepositoryQueryServiceSpy()
        let expectation = self.expectation(description: "fetch query successful")
        
        Network.shared.apollo.fetch(query: SpecificPostsQuery()){result in
            switch result{
            case .success( _):
                expectation.fulfill()
            case .failure(let error):
                 XCTFail("Cannot execute query. Error: \(error)")
            }
         }
        
        self.waitForExpectations(timeout: 2, handler: nil)
        XCTAssertFalse(repositoryQueryServiceSpy.getDataCalled)
    }
}


/// this mockup class extends the networkservice protocol
final class RepositoryQueryServiceSpy: NetworkService {
    private(set) var getDataCalled = false
    func fetchingGithubRepo(handler: @escaping (([RepositoryModel]) -> Void)) {
        getDataCalled = true
    }
}
