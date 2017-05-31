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

    private init() { }

    func getRequest(url: String, completion: @escaping (Data) -> Void) {

        guard let url = URL(string: url) else {
            return print("not a valid url string")
        }

        urlSession.dataTask(with: url) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                completion(data)
            }
        }.resume()
    }
}
