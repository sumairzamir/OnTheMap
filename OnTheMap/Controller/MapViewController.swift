//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import MapKit

// This class populates student coordinate information on to a map view.
// The class imports both MapKit and conforms to the MKMapViewDelegate.

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    // MARK:- View methods
    
    // The GET request is in viewWillAppear so that it is refreshed whenever the view appears, rather than loads.
    // The view remains loaded in the stack as the posting views are presented modally.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //  let location = CLLocationCoordinate2D(latitude: InformationPostingViewController.LocationCoordinates.latitude, longitude: InformationPostingViewController.LocationCoordinates.longitude)
        //  mapView.setCenter(location, animated: true)
        
        // Define the mapView as the delegate.
        
        mapView.delegate = self
        
        // Run the GET request for the student locations.
        
        NetworkGetRequests.requestStudentLocation(completionHandler: handleStudentLocationResponse(success:location:error:))
        
        // Center the map around the selected location
        // Specify the location based on the saved static variables from the geocode request.
        
        let location = CLLocationCoordinate2D(
            latitude: NetworkParameters.UserInformation.latitude,
            longitude: NetworkParameters.UserInformation.longitude
            
        )
        
        // Center the map.
        
        mapView.setCenter(location, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- IBActions
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        
        // Refresh the mapView by requesting the GET request again.
        
        NetworkGetRequests.requestStudentLocation(completionHandler: handleStudentLocationResponse(success:location:error:))
        
    }
    
    // MARK:- Response handling
    // This method handles the completionHandler from the GET request.
    
    func handleStudentLocationResponse(success: Bool, location: [Locations], error: Error?) {
        
        // If the GET request is successful, the student locations are mapped to annotations on the mapView.
        
        if success {
            
            // Set the student locations equal to the location information received from the GET request.
            
            StudentLocations.studentLocations = location
            
            // Extract and define the location information as necessary for annotations.
            
            // Initialise an array of annotations.
            
            var annotations = [MKPointAnnotation]()
            
            let locationInformation = StudentLocations.studentLocations
            
            // Define a for-in loop to map the location information into the annotations.
            
            for location in locationInformation {
                
                // Define the coordinates.
                
                let lat = CLLocationDegrees(location.latitude)
                let long = CLLocationDegrees(location.longitude)
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                // Define other student information received from the GET request.
                
                let first = location.firstName
                let last = location.lastName
                let mediaURL = location.mediaURL
                
                // Define the annotation.
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                // Append the annotation to the array of annotations define above.
                
                annotations.append(annotation)
                
            }
            
            // Update the mapView for the annotations added.
            
            self.mapView.addAnnotations(annotations)
            
        } else {
            
            // If an error occurs on the GET request. An AlertViewController is presented.
            // A customised error is passed through the network logic.
            
            showLogicFailure(title: "Retrieving information failed", message: error?.localizedDescription ?? "")
            
        }
        
    }
    
    // MARK: - mapView methods
    
    // This method defines the annotations as pins in the mapView.
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Similar to a TableView or CollectionView a reuseId is defined to manage the annotations in the view and outside of it.
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        // Define parameters for the pins.
        
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.canShowCallout = true
        
        // Select the presentation style which appears when the pin is tapped.
        
        pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return pinView
        
    }
    
    // This method opens up the URL received from the GET request when the callout from the pin is touched by the user.
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            if let openLink = view.annotation?.subtitle! {
                
                UIApplication.shared.open(URL(string: openLink)!)
                
            }
            
        }
        
    }
    
    // This method ends the current session and logs the user out.
    
    @IBAction func logoutTapped(_ sender: Any) {
        NetworkDeleteRequests.logout {
                self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}
