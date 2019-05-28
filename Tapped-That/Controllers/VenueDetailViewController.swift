//
//  VenueDetailViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/17/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit
import FloatingPanel
import CoreLocation
import MapKit

class VenueDetailViewController: UIViewController {
    var venue: Venue?
    
    // Venue socials and url
    @IBOutlet weak var venueWebsite: UILabel!
    // venue location
    @IBOutlet weak var venueLocation: UILabel!
    // primary category
    @IBOutlet weak var venueType: UILabel!
    // icon
    // venue name
    @IBOutlet weak var venueName: UILabel!
    // venue phone number
    @IBOutlet weak var venuePhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        print(venue?.contact)
        // Do any additional setup after loading the view.
    }
    @IBAction func onButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDirectionsButtonPress(_ sender: Any) {
        // opening the venue in the maps app
        if venue != nil {
            let lat = venue!.location.lat
            let lng = venue!.location.lng
            let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            
            let regionDistance: CLLocationDistance = 10000
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 100, longitudinalMeters: 100)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            
            let placeMark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placeMark)
            mapItem.name = venue!.venue_name
            mapItem.openInMaps(launchOptions: options)
        }
    }
    
    
    func updateUI() {
        if venue != nil {
            venueName.text = venue!.venue_name
            venueType.text = venue!.primary_category
            venueLocation.text = String("\(venue!.location.venue_address), \(venue!.location.venue_city), \(venue!.location.venue_state)")
            venuePhone.text = venue!.contact.venue_url
        }
    }
    
    
}
