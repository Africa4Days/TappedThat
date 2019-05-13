//
//  UntappdAPI.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/12/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import Foundation

struct BeerInfo: Codable {
    var bid: Int
    var brewery_id: Int
    var beer_abv: Float
    var beer_name: String
    var brewery_label: String
    var brewery_name: String
    var type_name: String
    var beer_label: String
}

struct Hits: Codable {
    var hits: [BeerInfo]
}

struct Beer: Codable {
    var results: [Hits]
}

class UntappdAPI {
    let getURL: String = "https://api.untappd.com/v4/"
    static let searchURL: String = "https://9wbo4rq3ho-dsn.algolia.net/1/indexes/*/queries?x-algolia-agent=Algolia%20for%20vanilla%20JavaScript%203.24.8&x-algolia-application-id=9WBO4RQ3HO&x-algolia-api-key=1d347324d67ec472bb7132c66aead485"
    
    static func searchForBeer(beer: String, closure: @escaping (Beer) -> ()) {
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
//            let dataString = String(data: data!, encoding: .utf8)
//            closure(dataString)
            
            let decoder = JSONDecoder()

            do {
                let beer = try decoder.decode(Beer.self, from: data!)
                closure(beer)
            } catch {
                print("Error: \(error)")
            }

        }
        
        task.resume()
    }
}
