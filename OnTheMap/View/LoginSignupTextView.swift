//
//  LoginSignupTextView.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 01/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation
import UIKit

class LoginSignupTextView: UITextView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let signupString = NSMutableAttributedString(string: "Don't have an account? Sign up")
        let signupURL = URL(string: "https://auth.udacity.com/sign-up")
        
        signupString.setAttributes([.link: signupURL!], range: NSMakeRange(23, 7))
        
        attributedText = signupString
        isUserInteractionEnabled = true
        isEditable = false
        
        backgroundColor = UIColor.clear
        textColor = UIColor.white
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 15)
        
        linkTextAttributes = [
            .foregroundColor: UIColor(red: 74/255, green: 158/255, blue: 199/255, alpha: 1)
        ]
    }
    
}


