//
//  ScrollingViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/17/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class ScrollingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var venues: FindBeerResponse?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        print(venues)
    }
    
    // TABLE VIEW METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues?.response.verified.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollCell", for: indexPath) as! ScrollingCell
        if let venueArray = venues {
            cell.venueName.text = venueArray.response.verified.items[indexPath.row].venue.venue_name
            cell.venueType.text = venueArray.response.verified.items[indexPath.row].venue.primary_category
        }
        return cell
    }

}
