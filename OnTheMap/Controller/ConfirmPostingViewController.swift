//
//  ConfirmPostingViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 06/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import MapKit


class ConfirmPostingViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapViewPosting: MKMapView!
    @IBOutlet weak var sendLocationPostButton: ButtonParameters!
    
    let long = InformationPostingViewController.LocationCoordinates.longitude
    let lat = InformationPostingViewController.LocationCoordinates.latitude
    let mediaURL = InformationPostingViewController.LocationCoordinates.mediaURL
    let mapString = InformationPostingViewController.LocationCoordinates.mapString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapViewPosting.delegate = self
        
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapViewPosting.setCenter(location, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapViewPosting.addAnnotation(annotation)
        self.mapViewPosting.isUserInteractionEnabled = false
        
    }
    
    
    @IBAction func postButtonAction(_ sender: Any) {
        
        NetworkLogic.requestUserInformation(completionHandler: handleUserRequestResponse(success:error:))
        
        
    }
    
    func handleUserRequestResponse(success: Bool, error: Error?) {
        if success {
             NetworkLogic.postStudentLocation(firstName: NetworkLogic.Auth.firstName, lastName: NetworkLogic.Auth.lastName, latitude: lat, longitude: long, mapString: mapString, mediaURL: mediaURL, uniqueKey: NetworkLogic.Auth.uniqueKey, completionHandler: handlePostResponse(success:error:))
        } else {
            print(error)
        }
    }
    
    func handlePostResponse(success: Bool, error: Error?) {
        
        if success {
            
            //Move once ready to refactor code
            DispatchQueue.main.async {
                print("The objectId is \(NetworkLogic.Auth.objectId)")
                self.dismiss(animated: true, completion: nil)
    
            }
            
        } else {
            print(error)
        }
    }
    
    
    
}
