//
//  ParksDetailController.swift
//  ForeverYoungFitness
//
//  Created by Riccardo Washington on 7/7/19.
//  Copyright © 2019 Riccardo Washington. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ParksDetailController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    private var Identifier = "Pin"
    
    var mapItemList = [MKMapItem]()
    var boundingRegion = MKCoordinateRegion()
    let mapView: MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    func setupMapView() {
        view.addSubview(mapView)
        mapView.fillSuperview()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        // Adjust the map to zoom/center to the annotations we want to show.
        mapView.setRegion(boundingRegion, animated: true)
        mapView.delegate = self
        mapView.showsUserLocation = true
        // Show the compass button in our navigation bar.
        let compassButton = MKCompassButton(mapView: mapView)
        compassButton.compassVisibility = .visible
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: compassButton)
        mapView.showsCompass = false
        // Use the compass in the navigation bar instead.
        // Make sure MKPinAnnotationView and our reuse identifier are recognized in this table view.
        mapView.register(MKPinAnnotationView.self, forAnnotationViewWithReuseIdentifier: Identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // We add the placemarks here to get the "drop" animation.
        if mapItemList.count == 1 {
            let mapItem: MKMapItem? = mapItemList[0]
            title = mapItem?.name
            // Add the single annotation to our map.
            let annotation = ParkAnnotation()
            annotation.coordinate = (mapItem?.placemark.location?.coordinate)!
            annotation.title = (mapItem?.name)!
            annotation.url = mapItem?.url
            mapView.addAnnotation(annotation)
            // We have only one annotation, select it's callout.
            mapView.selectAnnotation(mapView.annotations[0], animated: true)
        } else {
            title = "All Places"
            // Add all the found annotations to the map.
            for mapItem: MKMapItem in mapItemList {
                let annotation = ParkAnnotation()
                annotation.coordinate = (mapItem.placemark.location?.coordinate)!
                annotation.title = (mapItem.name)!
                // The URL will be used to open their website when the annotation's Info button is tapped.
                annotation.url = mapItem.url
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mapView.removeAnnotations(mapView.annotations)
    }
    
    // MARK: - MKMapViewDelegate
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("Failed to load the map: \(error)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: MKPinAnnotationView? = nil
        if (annotation is ParkAnnotation) {
            annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: Identifier, for: annotation) as? MKPinAnnotationView
            annotationView?.canShowCallout = true
            annotationView?.animatesDrop = true
            // If the annotation has a URL, add an extra Info button to the annotation view so users open that URL.
            let annotation = annotationView?.annotation as? ParkAnnotation
            if annotation?.url != nil {
                let rightButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = rightButton
            }
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Here we illustrate how to detect which annotation type was clicked on for its callout.
        let annotation: MKAnnotation? = view.annotation
        if (annotation is ParkAnnotation) {
            let annotation = view.annotation as? ParkAnnotation
            let url: URL? = annotation?.url
            // User tapped the annotation's Info Button.
            if url != nil {
                if let anUrl = url {
                    UIApplication.shared.open(anUrl, options: [:], completionHandler: {(_ success: Bool) -> Void in
                        // Completed openURL.
                    })
                }
            }
        }
    }
}





