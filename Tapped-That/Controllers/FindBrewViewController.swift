//
//  FindBrewViewController.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/15/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit
import MapKit
import FloatingPanel

class FindBrewViewController: UIViewController, FloatingPanelControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var fpc: FloatingPanelController!
    var venues: FindBeerResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        let contentVC = BeerTableViewController()
        if venues != nil {
            contentVC.venues = venues
        }
        
        fpc.set(contentViewController: contentVC)
        
        fpc.track(scrollView: contentVC.tableView)
        
        fpc.addPanel(toParent: self)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        fpc.removePanelFromParent(animated: true)
    }

}
