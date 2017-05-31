//
//  TestViewModel.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 31.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import XCTest
import RxSwift
@testable import DatingApp

class TestViewModel: XCTestCase {
    
    let viewModel = ViewModel(repository: PersonRepository.instance)
    
    func testInit() {
        XCTAssert((viewModel as Any) is ViewModel)
        
        XCTAssertEqual(viewModel.currentPersonIndex.value, 0)
        XCTAssertFalse(viewModel.networkReqOngoing.value)
        
        XCTAssert((viewModel.people.value as Any) is [Person])
        XCTAssert(viewModel.people.value.isEmpty)
    }
    
    func testGetWildCards() {
        XCTAssert(!viewModel.networkReqOngoing.value)
        XCTAssertEqual(viewModel.currentPersonIndex.value, 0)
        XCTAssert(viewModel.people.value.isEmpty)
        
        let expect = expectation(description: "fetching wild cards.")
        
        viewModel.fetchWildCards()
        XCTAssertTrue(self.viewModel.networkReqOngoing.value)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            XCTAssertFalse(self.viewModel.networkReqOngoing.value)
            XCTAssertEqual(self.viewModel.currentPersonIndex.value, 0)
            
            XCTAssert((self.viewModel.people.value as Any) is [Person])
            XCTAssertGreaterThan(self.viewModel.people.value.count, 0)
                
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
