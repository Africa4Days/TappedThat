//
//  ViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/12/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var beers: [BeerInfo]?
    var beerId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // SEARCH BAR FUNCTIONALITY
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.beers = []
        self.searchBar.endEditing(true)
        UntappdAPI.searchForBeer(beer: searchBar.text!) { (res) in
            self.beers = res.results[0].hits
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        UntappdAPI.searchForBeer(beer: searchText) { (res) in
            self.beers = []
            self.beers = res.results[0].hits
            
            DispatchQueue.main.async {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BeerCell
        cell.tag = indexPath.row
        
        if beers != nil {
            cell.beerName.text = beers![indexPath.row].beer_name
            cell.beerType.text = beers![indexPath.row].type_name
            cell.breweryName.text = beers![indexPath.row].brewery_name
            
            let imageURL = URL(string: beers![indexPath.row].beer_label)!
            
            UntappdAPI.getImage(imageURL: imageURL) { (image) in
                DispatchQueue.main.async {
                    if cell.tag == indexPath.row {
                        cell.beerImage.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SingleBeerViewController {
            vc.beerID = beerId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.beerId = beers![indexPath.row].bid
        performSegue(withIdentifier: "BeerSegue", sender: self)
    }
}

