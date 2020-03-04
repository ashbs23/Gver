////
////  MapViewController.swift
////  Gver
////
////  Created by Md. Ashikul Hosen on 18/2/20.
////  Copyright © 2020 BS-23. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//protocol HandleMapSearch {
//    func dropPinZoomIn(placemark: MKPlacemark)
//}
//
//class MapViewController: UIViewController {
//
//    let locationManager = CLLocationManager()
//    @IBOutlet weak var searchContainer: UIView!
//    @IBOutlet weak var mapView: MKMapView!
//
//    var resultSearchController: UISearchController? = nil
//    var selectedPin: MKPlacemark? = nil
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
//        let locationSearchTable = storyboard!
//            .instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
//        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
//        resultSearchController?.searchResultsUpdater = locationSearchTable
//        let searchBar = resultSearchController!.searchBar
//        searchContainer.addSubview(searchBar)
//        searchBar.sizeToFit()
//        searchBar.placeholder = "Search for places"
//        resultSearchController?.hidesNavigationBarDuringPresentation = false
//        resultSearchController?.obscuresBackgroundDuringPresentation = true
//        definesPresentationContext = true
//        locationSearchTable.mapView = mapView
//        locationSearchTable.handleMapSearchDelegate = self
//        mapView.delegate = self
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        resultSearchController?.isActive = true
//        DispatchQueue.main.async {
//            self.resultSearchController?.searchBar.becomeFirstResponder()
//        }
//    }
//
//    @objc func getDirections() {
//        if let selectedPin = selectedPin {
//            let mapItem = MKMapItem(placemark: selectedPin)
//            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//            mapItem.openInMaps(launchOptions: launchOptions)
//        }
//    }
//}
//
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
//extension MapViewController: HandleMapSearch {
//    func dropPinZoomIn(placemark: MKPlacemark) {
//        selectedPin = placemark
//        mapView.removeAnnotations(mapView.annotations)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = placemark.coordinate
//        annotation.title = placemark.name
//        if let city = placemark.locality,
//            let state = placemark.administrativeArea {
//            annotation.subtitle = "\(city) \(state)"
//        }
//        mapView.addAnnotation(annotation)
//        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion.init(center: placemark.coordinate, span: span)
//        mapView.setRegion(region, animated: true)
//    }
//}
//
//extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//        let reuseId = "pin"
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
//        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//        pinView?.pinTintColor = UIColor.orange
//        pinView?.canShowCallout = true
//        let smallSquare = CGSize(width: 30, height: 30)
//        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
//        button.setBackgroundImage(UIImage(named: "car"), for: .normal)
//        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
//        pinView?.leftCalloutAccessoryView = button
//        return pinView
//    }
//}
