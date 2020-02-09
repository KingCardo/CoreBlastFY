//
//  ParksTableViewController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/7/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

//
//  ParksTableViewController.swift
//  Flexx
//
//  Created by Riccardo Washington on 4/5/18.
//  Copyright © 2018 Riccardo Washington. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

private var kCellIdentifier = "cellIdentifier"

class ParkAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var title : String?
    var subtitle: String?
    var url: URL?
}

// MARK: -
class ParksTableViewController: UITableViewController,  CLLocationManagerDelegate {
    
    //@IBOutlet weak var viewAllButton: UIBarButtonItem!
    var places = [MKMapItem]()
    var boundingRegion = MKCoordinateRegion()
    var localSearch: MKLocalSearch?
    var locationManager: CLLocationManager?
    var userCoordinate = CLLocationCoordinate2D()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .darkGray
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if places.isEmpty {
            view.addSubview(activityIndicatorView)
            activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75).isActive = true
            
        }
        
        locationManager = CLLocationManager()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        
        
        if CLLocationManager.locationServicesEnabled() == false {
            print("\(#function): location services are not available.")
            // Display alert to the user.
            let alert = UIAlertController(title: "Location services", message: "Location services are not enabled on this device. Please enable location services in Settings.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            self.present(alert, animated: true) {() -> Void in }
            return
        }
        // Request "when in use" location service authorization.
        // If authorization has been denied previously, we can display an alert if the user has denied location services previously.
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager?.requestWhenInUseAuthorization()
        }
        // Ask for our location.
        self.locationManager?.delegate = self
        self.locationManager?.requestLocation()
        // When a location is delivered to the location manager delegate, the search will
        // actually take place. See the -locationManager:didUpdateLocations: method.
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let mapViewController = segue.destination as? MapMyRunViewController
//        if (segue.identifier == "showDetail") {
//            // Get the single item.
//            let selectedItemPath = tableView.indexPathForSelectedRow
//            let mapItem = places[(selectedItemPath?.row)!]
//            // Pass the new bounding region to the map destination view controller.
//            var region: MKCoordinateRegion = boundingRegion
//            // And center it on the single placemark.
//            
//            region.center = mapItem.placemark.coordinate
//            
//            mapViewController?.boundingRegion = region
//            // Pass the individual place to our map destination view controller.
//            mapViewController?.mapItemList = [mapItem]
//        } else if (segue.identifier == "showAll") {
//            // Pass the new bounding region to the map destination view controller.
//            mapViewController?.boundingRegion = boundingRegion
//            // Pass the list of places found to our map destination view controller.
//            mapViewController?.mapItemList = places
//        }
//    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        let mapItem = places[indexPath.row]
        cell?.textLabel?.text = mapItem.name
        if let aCell = cell {
            return aCell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let parksDetailController = ParksDetailController()
        let selectedItemPath = tableView.indexPathForSelectedRow
                    let mapItem = places[(selectedItemPath?.row)!]
                    // Pass the new bounding region to the map destination view controller.
                    var region: MKCoordinateRegion = boundingRegion
                    // And center it on the single placemark.
        
                    region.center = mapItem.placemark.coordinate
        
                    parksDetailController.boundingRegion = region
                    // Pass the individual place to our map destination view controller.
                    parksDetailController.mapItemList = [mapItem]
        self.navigationController?.pushViewController(parksDetailController, animated: true)
    }
    
    
    func startSearch(_ searchString: String?) {
        if localSearch?.isSearching ?? false {
            localSearch?.cancel()
        }
        // Confine the map search area to the user's current location.
        // Setup the area spanned by the map region.
        // We use the delta values to indicate the desired zoom level of the map.
        //
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(userCoordinate.latitude, userCoordinate.longitude)
        let newRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, latitudinalMeters: 12000, longitudinalMeters: 12000)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchString
        request.region = newRegion
        weak var weakSelf: ParksTableViewController? = self
        var completionHandler: MKLocalSearch.CompletionHandler? = nil
        //if let anItems = mapItems, let aRegion = request.self.boundingRegion {
        completionHandler = {(_ response: MKLocalSearch.Response?, _ error: Error?) -> Void in
            if error != nil {
                let errorStr = (error as NSError?)?.userInfo[NSLocalizedDescriptionKey] as? String
                let alertController = UIAlertController(title: "Could not find any places.", message: errorStr, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(ok)
                weakSelf?.present(alertController, animated: true) {() -> Void in }
            } else {
                self.places = (response?.mapItems)!
                // Used for later when setting the map's region in "prepareForSegue".
                self.boundingRegion = (response.self?.boundingRegion)!
               // weakSelf?.self.viewAllButton.isEnabled = weakSelf?.self.places != nil ? true : false
                weakSelf?.tableView.reloadData()
            }
            self.activityIndicatorView.stopAnimating()
          
        }
        
        if localSearch != nil {
            localSearch = nil
        }
       
        if let anArray = [Any]() as? [MKMapItem] {
            places = anArray
        }
        localSearch = MKLocalSearch(request: request)
        if let aHandler = completionHandler {
            localSearch?.start(completionHandler: aHandler)
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Remember for later the user's current location.
        let userLocation = locations.last
        if let aCoordinate = userLocation?.coordinate {
            userCoordinate = aCoordinate
        }
        manager.delegate = nil
        // We might be called again here, even though we
        // called "stopUpdatingLocation", so remove us as the delegate to be sure.
        // We have a location now, so start the search.
        startSearch("Parks")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // report any errors returned back from Location Services
    }
}

