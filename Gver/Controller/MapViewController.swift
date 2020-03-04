//
//  MapViewController.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 19/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark)
}

class MapViewController: UIViewController {

    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    
    var locationManagement = LocationManagement.reference
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let locationSearchTable = storyboard!
            .instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
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
        searchContainer.isHidden = true
        mapView.delegate = self
    }
    
    func locationZoomedIn() {
        let locationInformation = locationManagement.getLocationInformation()
        let coordinate = locationInformation["coordinate"] as? CLLocationCoordinate2D ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationZoomedIn()
//        resultSearchController?.isActive = true
//        DispatchQueue.main.async {
//            self.resultSearchController?.searchBar.becomeFirstResponder()
//        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
}

//extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            mapView!.setRegion(region, animated: true)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
//        print(error.localizedDescription)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            locationManager.requestLocation()
//        }
//    }
//}
