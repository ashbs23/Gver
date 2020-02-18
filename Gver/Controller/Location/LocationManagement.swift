//
//  LocationManager.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 17/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class LocationManagement: NSObject {
    var locationManager: CLLocationManager
    var delegate: CLLocationManagerDelegate?
    var mapView: MKMapView?
    
    init(on viewController: UIViewController, delegate: CLLocationManagerDelegate, mapView: MKMapView) {
        self.locationManager = CLLocationManager()
        super.init()
        self.delegate = delegate
        self.locationManager.delegate = self
        self.mapView = mapView
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
}

extension LocationManagement: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView!.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}

extension LocationManagement: UINavigationControllerDelegate {
    
}
