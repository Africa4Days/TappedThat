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
        print(venues)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScrollCell", for: indexPath)
        return cell
    }

}
