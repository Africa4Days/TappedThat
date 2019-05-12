//
//  ViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/12/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onButtonPress(_ sender: Any) {
        UntappdAPI.searchForBeer(beer: "Shorts") { (res) in
            print(res!)
        }
    }
    
}

