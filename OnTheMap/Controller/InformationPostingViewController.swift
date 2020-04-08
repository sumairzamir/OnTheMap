//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import CoreLocation

// This class appears when the user wishes to post a new pin for a location.
// The CoreLocation library is imported as geocoding occurs in this class.

class InformationPostingViewController: UIViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var postAddress: UITextField!
    @IBOutlet weak var postMediaURL: UITextField!
    @IBOutlet weak var postActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var findLocationButton: ButtonParameters!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // MARK:- View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- IBActions
    
    // This method dismisses the information entry controller.
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    // This method completes the geocoding and proceeds to the posting controller on success.
    
    @IBAction func postInformationButton(_ sender: Any) {
        
        // Adjust UI elements, i.e. disable them while the geocoding occurs.
        
        configureUI(true)
        
        // The geocoding is called based on the data entered in the address field.
        
        callGeocoder(address: postAddress.text!) {
            
            // The UI elements are re-enabled.
            
            self.configureUI(false)
            
            // Proceed to the following view controller.
            
            self.performSegue(withIdentifier: "ConfirmPostingSegue", sender: self)
            
        }
        
    }
    
    // MARK:- Geocoding method
    
    // This method calls the CLGecoder method to return coordinates for a location entered as a string.
    
    func callGeocoder(address: String, completionHandler: @escaping () -> Void) {
        
        // Define the geocoder.
        
        let geocoder = CLGeocoder()
        
        // The geocoder converts the address into coordinates (placemarks) as below.
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            // A guard is necessary as the geocode may fail.
            
            guard
                let placemarks = placemarks,
                let location = placemarks.first,
                let lat = location.location?.coordinate.latitude,
                let long = location.location?.coordinate.longitude
                
                else {
                    
                    // If the geocode fails an Alert View is presented to the user.
                    
                    self.showGeoCodeFailure(title: "Unable to find location", message: ErrorResponse.geocodeError.localizedDescription)
                    
                    // The UI elements are re-enabled and activity indicator stops animating.
                    
                    self.configureUI(false)
                    return
            }
            
            // The location data received from the geocoding are saved to the static variables.
            
            NetworkParameters.UserInformation.latitude = lat
            NetworkParameters.UserInformation.longitude = long
            NetworkParameters.UserInformation.mapString = address
            NetworkParameters.UserInformation.mediaURL = self.postMediaURL.text!
            
            // The completionHandler is called.
            
            completionHandler()
            
        }
        
    }
    
    // MARK: - Alertview
    // Alert view pop-up if there is an error received on the GET request.
    
    func showGeoCodeFailure(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Method to configure UI elements
    
    func configureUI(_ attemptLocationGeocode: Bool) {
        
        // If a geocode request is called the activity indicator should animate.
        
        if attemptLocationGeocode {
            
            postActivityIndicator.startAnimating()
            
        } else {
            
            postActivityIndicator.stopAnimating()
            
        }
        
        // If the geocode request is true then the UI elements are disabled.
        
        postAddress.isEnabled = !attemptLocationGeocode
        postMediaURL.isEnabled = !attemptLocationGeocode
        cancelButton.isEnabled = !attemptLocationGeocode
        findLocationButton.isEnabled = !attemptLocationGeocode
        
    }
    
}
