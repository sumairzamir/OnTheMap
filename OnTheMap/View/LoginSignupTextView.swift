//
//  LoginSignupTextView.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 01/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation
import UIKit

// This class specifies the parameters for the sign up TextView in the LoginViewController.
// The class has been specified in the Storyboard for LoginSignupTextView.

class LoginSignupTextView: UITextView {
    
    // Similar to viewDidLoad for UI/xml components.
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Define text within the TextView.
        
        let signupString = NSMutableAttributedString(string: "Don't have an account? Sign up")
        
        // Define URL to open on touch.
        
        let signupURL = URL(string: "https://auth.udacity.com/sign-up")
        
        // Define the range of the string where the URL is applied.
        
        signupString.setAttributes([.link: signupURL!], range: NSMakeRange(23, 7))
        
        // Define parameters for the TextView.
        
        attributedText = signupString
        isUserInteractionEnabled = true
        isEditable = false
        backgroundColor = UIColor.clear
        textColor = UIColor.white
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 15)
        
        linkTextAttributes = [
            
            // Colour based off Udacity colour scheme.
            
            .foregroundColor: UIColor(red: 74/255, green: 158/255, blue: 199/255, alpha: 1)
        ]
        
    }
    
}
