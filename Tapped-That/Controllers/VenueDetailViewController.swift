//
//  VenueDetailViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/17/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit
import FloatingPanel

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
