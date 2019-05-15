//
//  UntappdAPI.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/12/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import Foundation
import UIKit

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

// SINGLE BEER VIEW CONTROLLER STRUCTS

struct BreweryLocation: Codable {
    var brewery_city: String
    var brewery_state: String
    var lat: Double
    var lng: Double
}

struct BreweryContact: Codable {
    var twitter: String
    var facebook: String
    var url: String
}

struct Brewery: Codable {
    var brewery_id: Int
    var brewery_name: String
    var brewery_page_url: String
    var brewery_label: String
    var country_name: String
    var contact: BreweryContact
    var location: BreweryLocation
}

struct SingleBeerInfo: Codable {
    var bid: Int
    var beer_name: String
    var beer_label: String
    var beer_abv: Float
    var beer_ibu: Int
    var beer_description: String
    var beer_style: String
    var brewery: Brewery
}

struct Beers: Codable {
    var beer: SingleBeerInfo
}

struct SingleBeer: Codable {
    var response: Beers
}

class UntappdAPI {
    static let access_token = "83C7A12B4243CF719F2454481121FD23550ECB23"
    static let getURL: String = "https://api.untappd.com/v4"
    static let searchURL: String = "https://9wbo4rq3ho-dsn.algolia.net/1/indexes/*/queries?x-algolia-agent=Algolia%20for%20vanilla%20JavaScript%203.24.8&x-algolia-application-id=9WBO4RQ3HO&x-algolia-api-key=1d347324d67ec472bb7132c66aead485"
    
    // SEARCHING FOR A BEER BY BEER NAME
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
    
    // GETTING AN IMAGE OF A BEER OR BREWERY
    static func getImage(imageURL: URL, closure: @escaping (UIImage) -> ()) {
        let session = URLSession.shared
        
        let downloadImage = session.dataTask(with: imageURL) { (data, response, error) in
            if let imageData = data {
                let image = UIImage(data: imageData)
                closure(image!)
            }
        }
        
        downloadImage.resume()
    }
    
    // GETTING INFO ON A SPECIFIC BEER WITH ITS ID
    static func getBeerInfo(beerID: Int, closure: @escaping (SingleBeer) -> ()) {
        var url = URLComponents(string: "\(getURL)/beer/info/\(beerID)")!
        
        let compact = "enhanced"
        let dist_pref = "m"
        let lat = "43.15630491545616"
        let lng = "-85.56908186136279"
        let radius = "10"
        
        let param = ["compact": compact, "dist_pref": dist_pref, "lat": lat, "lng": lng, "radius": radius,"access_token": access_token]
        var items = [URLQueryItem]()
        
        for (key, value) in param {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        url.queryItems = items
        
        let session = URLSession.shared
        let request = URLRequest(url: url.url!)
        
        let task = session.dataTask(with: request) { (data, response, error) in
//            let dataString = String(data: data!, encoding: .utf8)
//            closure(dataString)
            
            let decoder = JSONDecoder()

            do {
                let beerInfo = try decoder.decode(SingleBeer.self, from: data!)
                closure(beerInfo)
            } catch {
                print("Error: \(error)")
            }
        }
        
        task.resume()
    }
    
    // FINDING A BEER BY ID
    static func findABeer(beerID: Int, lat: String, lng: String, closure: @escaping (Any) -> ()) {
        var url = URLComponents(string: "\(getURL)/beer/find/\(beerID)")!
        
        let param = ["dis_pref": "m", "lat": lat, "lng": lng, "mode": "enhanced", "radius": "10", "access_token": access_token]
        var items = [URLQueryItem]()
        
        for (key, value) in param {
            items.append(URLQueryItem(name: key, value: value))
        }
        
        url.queryItems = items
        
        let session = URLSession.shared
        let request = URLRequest(url: url.url!)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            
            do {
                let locationInfo = try decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: data!)
                closure(locationInfo)
            } catch {
                print("Error: \(error)")
            }
        }
        
        task.resume()
    }
}
