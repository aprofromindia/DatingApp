//
//  TestPerson.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 31.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import XCTest
@testable import DatingApp

class TestPerson: XCTestCase {
    
    let person = Person(age: 40, city: "Berlin", firstName: "Tom",
                        id: "1234", job: "Waiter", name: "Tom John",
                        wantChildren: true, isSmoker: false, postCode: 10901,
                        images: ["image1", "image2", "image3"])
    
    func testInit() {
        XCTAssertEqual(person.age, 40)
        XCTAssert((person.age as Any) is UInt)
        XCTAssertFalse(((person.age as Any) is Int))
        
        XCTAssertEqual(person.city, "Berlin")
        XCTAssertNotEqual(person.city, "Kolkata")
        XCTAssertEqual(person.postCode, 10901)
        
        XCTAssertEqual(person.firstName, "Tom")
        XCTAssertEqual(person.images.count, 3)
        XCTAssertFalse(person.isSmoker)
        XCTAssertTrue(person.wantChildren)
    }
}
