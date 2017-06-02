//
//  AppProvider.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 02.06.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit

class AppProvider {
    
    static func providePersonRepository() -> PersonRepository {
        return PersonRepository(restClient: provideRestClient())
    }
    
    static func provideRestClient() -> RESTClient {
        return RESTClient(urlSession: provideUrlSession())
    }
    
    static func provideUrlSession() -> URLSession {
        return URLSession.shared
    }
}
