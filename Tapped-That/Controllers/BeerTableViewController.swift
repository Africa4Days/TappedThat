//
//  BeerTableViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/16/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {
    
    var venues: FindBeerResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registering a tableview cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ScrollCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venues?.response.verified.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollCell", for: indexPath)
        cell.textLabel?.text = venues!.response.verified.items[indexPath.row].venue.venue_name
        return cell
    }

}
