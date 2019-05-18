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

class FindBrewViewController: UIViewController, FloatingPanelControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var fpc: FloatingPanelController!
    var secondFpc: FloatingPanelController!
    
    var venues: FindBeerResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ScrollingViewController") as! ScrollingViewController
        if venues != nil {
            contentVC.venues = venues
            var locations = [MKPointAnnotation]()
            
            // adding annotation points to the map
            for venue in venues!.response.verified.items {
                let venuePoint = MKPointAnnotation()
                let lat = venue.venue.location.lat
                let lng = venue.venue.location.lng
                venuePoint.title = venue.venue.venue_name
                
                venuePoint.coordinate = CLLocationCoordinate2DMake(lat, lng)
                locations.append(venuePoint)
            }
            print(locations)
            mapView.addAnnotations(locations)
        }
        
        // setting up first fpc
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        fpc.addPanel(toParent: self)
        
        //setting up second fpc
        let vc = storyboard?.instantiateViewController(withIdentifier: "VenueDetail") as! VenueDetailViewController
        secondFpc = FloatingPanelController()
        secondFpc.set(contentViewController: vc)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        fpc.removePanelFromParent(animated: true)
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        secondFpc = FloatingPanelController()
        secondFpc.set(contentViewController: vc)
        secondFpc.addPanel(toParent: self)
        fpc.move(to: .half, animated: true)
    }
    
}
