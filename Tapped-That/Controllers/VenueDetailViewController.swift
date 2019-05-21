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
    // venue location
    // primary category
    // icon
    // venue name

    override func viewDidLoad() {
        super.viewDidLoad()
        print(venue)
        // Do any additional setup after loading the view.
    }
    @IBAction func onButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
