//
//  RESTClient.swift
//  DatingApp
//
//  Created by Choudhury, Apratim (201) on 25.05.17.
//  Copyright © 2017 Apro. All rights reserved.
//

import UIKit

struct RESTClient {
    
    static let shared = RESTClient()
    let urlSession = URLSession.shared
    
    private init(){}
    
    func getRequest(url: String, completion: @escaping (Data) -> Void) {
        
        urlSession.dataTask(with: URL(string: url)!) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                completion(data)
            }
            }.resume()
    }
}
