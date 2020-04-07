//
//  InformationPostingViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit
import CoreLocation

class InformationPostingViewController: UIViewController {
    
    @IBOutlet weak var postAddress: UITextField!
    @IBOutlet weak var postMediaURL: UITextField!
    @IBOutlet weak var postActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var findLocationButton: ButtonParameters!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    struct LocationCoordinates {
        static var latitude: Double = 51.5001524
        static var longitude: Double = -0.1262362
        static var mediaURL: String = ""
        static var mapString: String = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // Make naming convention consistent!
    
    @IBAction func postInformationButton(_ sender: Any) {
        
        configureUI(true)
        callGeocoder(address: postAddress.text!) {
            self.configureUI(false)
            print("\(LocationCoordinates.latitude) \(LocationCoordinates.longitude)")
            self.performSegue(withIdentifier: "ConfirmPostingSegue", sender: self)
        }
        
    }
    
    func callGeocoder(address: String, completionHandler: @escaping () -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            guard
                let placemarks = placemarks,
                let location = placemarks.first,
                let lat = location.location?.coordinate.latitude,
                let long = location.location?.coordinate.longitude
                
                else {
                    print(error)
                    return
            }
            
            print("\(lat) \(long)")
            
            LocationCoordinates.latitude = lat
            LocationCoordinates.longitude = long
            LocationCoordinates.mapString = address
            LocationCoordinates.mediaURL = self.postMediaURL.text!
            
            print("\(LocationCoordinates.latitude) \(LocationCoordinates.longitude)")
            completionHandler()
            
        }
        
    }
    
    func configureUI(_ attemptLocationGeocode: Bool) {
           if attemptLocationGeocode {
               postActivityIndicator.startAnimating()
           } else {
               postActivityIndicator.stopAnimating()
               
           }
           
           postAddress.isEnabled = !attemptLocationGeocode
           postMediaURL.isEnabled = !attemptLocationGeocode
           cancelButton.isEnabled = !attemptLocationGeocode
        findLocationButton.isEnabled = !attemptLocationGeocode
           
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
