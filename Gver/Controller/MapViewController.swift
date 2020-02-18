//
//  MapViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 18/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    let locationManager = CLLocationManager()
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var showMyLocationButton: UIButton!
    
    var resultSearchController: UISearchController? = nil
    
    var locationManagement: LocationManagement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchContainer.addSubview(searchBar)
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resultSearchController?.isActive = true
        DispatchQueue.main.async {
            self.resultSearchController?.searchBar.becomeFirstResponder()
        }
    }
    
    func updateUI() {
        showMyLocationButton.layer.cornerRadius = showMyLocationButton.frame.size.height / 2
        showMyLocationButton.clipsToBounds = true
    }
    
    @IBAction func showMyLocationButtonPressed(_ sender: Any) {
        
    }
}

extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}
