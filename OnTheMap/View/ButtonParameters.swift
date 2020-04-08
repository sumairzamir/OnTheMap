//
//  ButtonParameters.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 02/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation
import UIKit

// This class specifies the parameters for Buttons through the app.
// The class has been specified in the Storyboard for each Button.

class ButtonParameters: UIButton {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        // Define parameters for the Button.
        
        layer.cornerRadius = 5
        backgroundColor = UIColor(red: 74/255, green: 158/255, blue: 199/255, alpha: 1)
        setTitleColor(.white, for: .normal)
        
    }
    
}
