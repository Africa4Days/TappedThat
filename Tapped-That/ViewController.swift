//
//  ViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/12/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var beers: [BeerInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        tableView.dataSource = self
    }
    
    // SEARCH BAR FUNCTIONALITY
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UntappdAPI.searchForBeer(beer: searchBar.text!) { (res) in
            self.beers = res.results[0].hits
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    // TABLEVIEW METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if beers != nil {
            cell.textLabel?.text = beers![indexPath.row].beer_name
            let imageURL = URL(string: beers![indexPath.row].beer_label)!
            
            UntappdAPI.getImage(imageURL: imageURL) { (image) in
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                    self.tableView.reloadData()
                }
            }
        }
        
        return cell
    }
}

