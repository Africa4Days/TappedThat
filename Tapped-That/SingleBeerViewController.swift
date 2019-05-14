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
    var beerInfo: SingleBeerInfo?

    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var breweryName: UILabel!
    @IBOutlet weak var beerType: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UntappdAPI.getBeerInfo(beerID: beerID!) { (res) in
            self.beerInfo = res.response.beer
            
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    // Update the UI when the data is fetched
    func updateUI() {
        beerName.text = beerInfo?.beer_name
        breweryName.text = beerInfo?.brewery.brewery_name
        beerType.text = beerInfo?.beer_style
        beerDescription.text = beerInfo?.beer_description
    }
}
