//
//  SingleBeerViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/13/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit
import CoreLocation

class SingleBeerViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    var beerID: Int?
    var beerInfo: SingleBeerInfo?
    var lat: Double?
    var lng: Double?

    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var breweryName: UILabel!
    @IBOutlet weak var beerType: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerABV: UILabel!
    @IBOutlet weak var beerIBU: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UntappdAPI.getBeerInfo(beerID: beerID!) { (res) in
            self.beerInfo = res.response.beer
            
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
        
        // If user has not said ok or said no ask again on view load
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        } else {
            print("User needs to accept this SHIT YO!")
        }
    }
    
    // User looking for the beer near their area
    @IBAction func onFindBrewClick(_ sender: Any) {
    }
    
    // Update the UI when the data is fetched
    func updateUI() {
        beerName.text = beerInfo?.beer_name
        breweryName.text = beerInfo?.brewery.brewery_name
        beerType.text = beerInfo?.beer_style
        beerDescription.text = beerInfo?.beer_description
    }
    
    // LOCATION MANAGER DELEGATE METHODS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to grab user coordinates")
    }
}
