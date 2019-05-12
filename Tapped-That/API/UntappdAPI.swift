//
//  UntappdAPI.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/12/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import Foundation

class UntappdAPI {
    let getURL: String = "https://api.untappd.com/v4/"
    static let searchURL: String = "https://9wbo4rq3ho-dsn.algolia.net/1/indexes/*/queries?x-algolia-agent=Algolia%20for%20vanilla%20JavaScript%203.24.8&x-algolia-application-id=9WBO4RQ3HO&x-algolia-api-key=1d347324d67ec472bb7132c66aead485"
    
    static func searchForBeer(beer: String, closure: @escaping (Any?) -> ()) {
        let json: [String: Any] = [
            "requests": [
                [
                    "indexName": "beer",
                    "params": "query=\(beer)"
                ]
            ]
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let session = URLSession.shared
        let url = URL(string: searchURL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = session.uploadTask(with: request, from: jsonData) { (data, response, error) in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                closure(dataString)
            }
        }
        
        task.resume()
    }
}
