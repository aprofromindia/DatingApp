//
//  Person.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 25.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import Foundation

final class Person {
    let age: Int
    let city: String
    let firstName: String
    let id: String
    let job: String
    let name: String
    let wantChildren: Bool
    let isSmoker: Bool
    let postCode: Int
    let images: [String]

    init(age: Int, city: String, firstName: String,
         id: String, job: String, name: String,
         wantChildren: Bool, isSmoker: Bool,
         postCode: Int, images: [String]) {
        self.age = age
        self.city = city
        self.firstName = firstName
        self.id = id
        self.job = job
        self.name = name
        self.wantChildren = wantChildren
        self.isSmoker = isSmoker
        self.postCode = postCode
        self.images = images
    }
}
