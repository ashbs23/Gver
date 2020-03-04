//
//  LocationSearchTable.swift
//  Gver
//
//  Created by Md. Ashikul Hosen on 18/2/20.
//  Copyright © 2020 BS-23. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    var searchView: UIView? = nil
    var handleMapSearchDelegate: HandleMapSearch? = nil
    var locationManagement = LocationManagement.reference
}

extension LocationSearchTable {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TableCustomCellID.searchTableCell)!
        let selectedItem = matchingItems[indexPath.row].placemark
        let address = "\(selectedItem.name ?? ""), \(parseAddress(selectedItem: selectedItem))"
        locationManagement.storeLocation(address: address, coordinate: selectedItem.coordinate)
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func parseAddress(selectedItem: MKPlacemark) -> String {
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
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.tableFooterView = UIView(frame: .zero)
            self.tableView.reloadData()
        }
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}
