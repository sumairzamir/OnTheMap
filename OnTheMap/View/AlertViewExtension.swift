//
//  AlertViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 08/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation
import UIKit

// This class extends the UIViewController class to include a defined Alertview called in the controllers as needed.

extension UIViewController {
    
    // MARK: - Alertview
    // Alert view pop-up if there is an error received.
    
    func showLogicFailure(title: String, message: String) {
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        
    }
}
