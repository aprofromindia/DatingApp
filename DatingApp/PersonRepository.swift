//
//  PersonRepository.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 25.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonRepository {
    private let _urlString = "http://devrecruitmentapi-affinitasplaygroundstaticbucket-13lxtfh91eyhc.s3-website-eu-west-1.amazonaws.com/"
    
    static let instance = PersonRepository()
    let restClient = RESTClient.shared
    var people: [Person]!
    
    private init(){}
    
    func getPeople(completion: @escaping ([Person]) -> Void) {
        restClient.getRequest(url: _urlString) { [weak self] data in
            
            DispatchQueue.global(qos: .userInitiated).async {
                let results = JSON(data: data).arrayValue
                self?.people = [Person]()
                
                for person in results {
                    
                    let person1 = Person(age: person["age"].intValue,
                                         city: person["city"].stringValue,
                                         firstName: person["firstname"].stringValue,
                                         id: person["id"].stringValue,
                                         job: person["job"].stringValue,
                                         name: person["name"].stringValue,
                                         wantChildren: person["wish_for_children"].boolValue,
                                         isSmoker: person["smoker"].boolValue,
                                         postCode: person["postcode"].intValue,
                                         images: person["images"].arrayObject as! [String])
                    
                    self?.people.append(person1)
                }
                
                DispatchQueue.main.async {
                    completion((self?.people)!)
                }
            }
        }
    }


}
