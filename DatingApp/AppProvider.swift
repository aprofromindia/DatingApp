//
//  AppProvider.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 02.06.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit

struct AppProvider {
    
    private static let restClient = RESTClient(urlSession: provideUrlSession())
    private static let personRepository = PersonRepository(restClient: provideRestClient())
    
    static func providePersonRepository() -> PersonRepository {
        return personRepository
    }
    
    static func provideRestClient() -> RESTClient {
        return restClient
    }
    
    private static func provideUrlSession() -> URLSession {
        return URLSession.shared
    }
}
