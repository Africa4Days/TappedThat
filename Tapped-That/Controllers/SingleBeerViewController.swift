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
    var venues: FindBeerResponse?

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
        
        UntappdAPI.getBeerInfo(beerID: beerID ?? 1) { (res) in
            self.beerInfo = res.response.beer
            
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
        
    }
    
    // prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FindBrewViewController {
            vc.venues = venues
        }
    }
    
    // User looking for the beer near their area
    @IBAction func onFindBrewClick(_ sender: Any) {
        if lat != nil && lng != nil && beerID != nil {
            UntappdAPI.findABeer(beerID: beerID!, lat: String(lat!), lng: String(lng!)) { (res) in
                self.venues = res
                
                DispatchQueue.main.async {
                    // perform segue after the venues has been set
                    self.performSegue(withIdentifier: "FindABeer", sender: self)
                }
            }
        }
    }
    
    // Update the UI when the data is fetched
    func updateUI() {
        beerName.text = beerInfo?.beer_name
        breweryName.text = beerInfo?.brewery.brewery_name
        beerType.text = beerInfo?.beer_style
        beerDescription.text = beerInfo?.beer_description
        
        let imageURL = URL(string: beerInfo!.beer_label)!
        UntappdAPI.getImage(imageURL: imageURL) { (image) in
            DispatchQueue.main.async {
                self.beerImage.image = image
            }
        }
    }
    
    // LOCATION MANAGER DELEGATE METHODS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = locations[0].coordinate.latitude
        lng = locations[0].coordinate.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to grab user coordinates")
    }
}
