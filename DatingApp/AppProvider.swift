//
//  AppProvider.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 02.06.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit

struct AppProvider {
    
    static let restClient = RESTClient(urlSession: AppProvider.urlSession)
    static let personRepository = PersonRepository(restClient: AppProvider.restClient)
    private static let urlSession = URLSession.shared
}
