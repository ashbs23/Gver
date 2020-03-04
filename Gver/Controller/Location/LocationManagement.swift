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
import Firebase

class LocationManagement: NSObject {
    
    var locationInformation: [String: Any]!
    var locationManager: CLLocationManager!
    var geoCoder: CLGeocoder!
    static let reference = LocationManagement(locationInformation: [:])
    
    private init(locationInformation: [String: Any]) {
        super.init()
        self.locationInformation = locationInformation
        geoCoder = CLGeocoder()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    func parseAddress(selectedItem: CLPlacemark) -> String {
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil)
            ? " " : ""
        
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil)
            && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil)
            ? ", " : ""
        
        let secondSpace = (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(format: "%@%@%@%@%@%@%@",
                                 //street number
                                 selectedItem.subThoroughfare ?? "",
                                 firstSpace,
                                 //street name
                                 selectedItem.thoroughfare ?? "",
                                 comma,
                                 //city
                                 selectedItem.locality ?? "",
                                 secondSpace,
                                 //state
                                 selectedItem.administrativeArea ?? "")
        return addressLine
    }
    
    func storeLocation(address: String, coordinate: CLLocationCoordinate2D) {
        locationInformation["address"] = address
        locationInformation["lat"] = coordinate.latitude
        locationInformation["lng"] = coordinate.longitude
        locationInformation["coordinate"] = coordinate
    }
    
    func getLocationInformation() -> [String: Any] {
        return self.locationInformation
    }
}

extension LocationManagement: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            var address = ""
            geoCoder.reverseGeocodeLocation(location) { (clplacemarks, error) in
                if let e = error {
                    print(e.localizedDescription)
                    return
                } else {
                    if let placemark = clplacemarks?.first {
                        address = self.parseAddress(selectedItem: placemark)
                        self.storeLocation(address: address,
                                           coordinate: location.coordinate)
                    }
                }
            }
            
        }
        locationManager.stopUpdatingLocation()
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

