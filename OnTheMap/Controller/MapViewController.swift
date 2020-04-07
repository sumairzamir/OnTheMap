//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
//
//        if NetworkLogic.Auth.objectId != "" {
////
        ///Check as part of completionhandler?....
////
//            let location = CLLocationCoordinate2D(latitude: InformationPostingViewController.LocationCoordinates.latitude, longitude: InformationPostingViewController.LocationCoordinates.longitude)
//
//        mapView.setCenter(location, animated: true)

    mapView.delegate = self
//        }
    
    // Run the get request to get student locations
    
    _ = NetworkLogic.requestStudentLocation(completionHandler: { (locations, error) in
        StudentLocations.studentLocations = locations
        
        // On the main thread
        
        DispatchQueue.main.async {
            print(StudentLocations.studentLocations.count)
            
            // Assign the student locations to annotations in the MKMapKit
            
            var annotations = [MKPointAnnotation]()
            
            let locationInformation = StudentLocations.studentLocations
            
            for location in locationInformation {
                
                let lat = CLLocationDegrees(location.latitude)
                let long = CLLocationDegrees(location.longitude)
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = location.firstName
                let last = location.lastName
                let mediaURL = location.mediaURL
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = mediaURL
                
                annotations.append(annotation)
                
            }
            
            self.mapView.addAnnotations(annotations)
            
            
        }
    })
    
    // Do any additional setup after loading the view.
            
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mapView.delegate = self
//
//
//        // Run the get request to get student locations
//
//        _ = NetworkLogic.requestStudentLocation(completionHandler: { (locations, error) in
//            StudentLocations.studentLocations = locations
//
//            // On the main thread
//
//            DispatchQueue.main.async {
//                print(StudentLocations.studentLocations.count)
//
//                // Assign the student locations to annotations in the MKMapKit
//
//                var annotations = [MKPointAnnotation]()
//
//                let locationInformation = StudentLocations.studentLocations
//
//                for location in locationInformation {
//
//                    let lat = CLLocationDegrees(location.latitude)
//                    let long = CLLocationDegrees(location.longitude)
//
//                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
//
//                    let first = location.firstName
//                    let last = location.lastName
//                    let mediaURL = location.mediaURL
//
//                    let annotation = MKPointAnnotation()
//                    annotation.coordinate = coordinate
//                    annotation.title = "\(first) \(last)"
//                    annotation.subtitle = mediaURL
//
//                    annotations.append(annotation)
//
//                }
//
//                self.mapView.addAnnotations(annotations)
//
//
//            }
//        })
        
        // Do any additional setup after loading the view.
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.canShowCallout = true
        pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        
        //        if pinView?.annotation?.subtitle == "" && pinView?.annotation?.title == "" {
        //            pinView?.isHidden = true
        //        } else if pinView?.annotation?.subtitle == "" {
        //            pinView?.rightCalloutAccessoryView?.isHidden = true
        //            pinView?.isUserInteractionEnabled = false
        //        } else {
        //
        //                   pinView?.canShowCallout = true
        //                   pinView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        //        }
        
        return pinView
        
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        if control == view.rightCalloutAccessoryView {
            
            if let openLink = view.annotation?.subtitle! {
                
                UIApplication.shared.open(URL(string: openLink)!)
                
            }
            
        }
        
    }
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        NetworkLogic.logout {
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

