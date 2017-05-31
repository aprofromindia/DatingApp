//
//  TestPersonRepository.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 31.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import XCTest
@testable import DatingApp

class TestPersonRepository: XCTestCase {
    
    let repository = PersonRepository.instance
    
    func testGetWildCards() {
        let expect = expectation(description: "Get wild cards")
        
        repository.getWildCards { people in
            XCTAssert((people as Any) is [Person])
            XCTAssertGreaterThan(people.count, 0)
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
