//
//  SingleBeerViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/13/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class SingleBeerViewController: UIViewController {
    var beerID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UntappdAPI.getBeerInfo(beerID: beerID!) { (res) in
            print(res!)
        }
    }
    
    
    
}
