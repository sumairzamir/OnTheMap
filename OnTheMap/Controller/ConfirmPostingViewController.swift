//
//  ConfirmPostingViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 06/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import MapKit

// This class posts the submitted location (from the geocode) to the network via a POST request.

class ConfirmPostingViewController: UIViewController, MKMapViewDelegate {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var mapViewPosting: MKMapView!
    @IBOutlet weak var sendLocationPostButton: ButtonParameters!
    
    // MARK:- View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the mapView as the delegate.
        
        self.mapViewPosting.delegate = self
        
        // Center the map around the selected location
        // Specify the location based on the saved static variables from the geocode request.
        
        let location = CLLocationCoordinate2D(
            latitude: NetworkParameters.UserInformation.latitude,
            longitude: NetworkParameters.UserInformation.longitude
            
        )
        
        // Center the map.
        
        mapViewPosting.setCenter(location, animated: true)
        
        // Present a pin at the chosen location.
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapViewPosting.addAnnotation(annotation)
        
        // The user is not allowed to move the mapView as there is no need to.
        
        self.mapViewPosting.isUserInteractionEnabled = false
        
    }
    
    // MARK:- IBActions
    
    // This method runs the network logic to submit the request.
    
    @IBAction func postButtonAction(_ sender: Any) {
        
        // The first request is a GET request. The relevant information for the loggedin user is requested from the server.
        // The details of the user such as first name and last name are saved as static variables as needed in the proceeding POST request.
        
        NetworkGetRequests.requestUserInformation(completionHandler: handleUserRequestResponse(success:error:))
        
    }
    
    // MARK:- Response handling
    
    // This method handles the initial GET request.
    
    func handleUserRequestResponse(success: Bool, error: Error?) {
        
        // If the GET request is successful, the next stage of posting begings.
        // A POST request is then called to post the student information to the network.
        
        if success {
            
             NetworkPostRequests.postStudentLocation(
                
                // The following parameters are sent to the network. These are the static variables saved for the user.
                
                firstName: NetworkParameters.UserInformation.firstName,
                lastName: NetworkParameters.UserInformation.lastName,
                latitude: NetworkParameters.UserInformation.latitude,
                longitude: NetworkParameters.UserInformation.longitude,
                mapString: NetworkParameters.UserInformation.mapString,
                mediaURL: NetworkParameters.UserInformation.mediaURL,
                
                // On logging in a unique key was received from the network. This key is needed to post successfully.
                
                uniqueKey: NetworkParameters.Auth.uniqueKey,
                
                // Response handling continues here for the POST request.
                
                completionHandler: handlePostResponse(success:error:))
            
        } else {
            
            // If the GET request failed, this error is managed by the AlertView here.
            // This error message here is customised as a network error.
            
            self.showNetworkLogicFailure(title: "Network error", message: error?.localizedDescription ?? "")
            
        }
        
    }
    
    // This method handles the POST request.
    
    func handlePostResponse(success: Bool, error: Error?) {
        
        // If the POST request is successful the view controller is dismissed. The user returns to the tab bar view controller.
        
        if success {
            
                self.dismiss(animated: true, completion: nil)
            
        } else {
            
            // If the POST request fails, an AlertView is shown.
            // The error here is customised as a posting error.
            
            self.showNetworkLogicFailure(title: "Post error", message: error?.localizedDescription ?? "")
            
        }
        
    }
    
    // MARK: - Alertview
    // Alert view pop-up if there is an error received on the network requests.
    
    func showNetworkLogicFailure(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
