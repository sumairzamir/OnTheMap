//
//  ViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit

// This class contains code run on interaction at the login stage.

class LoginViewController: UIViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: ButtonParameters!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    // MARK:- View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK:- IBActions
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Configure UI elements, i.e. disable them while the login process occurs.
        
        setLoggingIn(true)
        
        // Run the POST request to login. Data from the text fields are sent to the network.
        
        NetworkPostRequests.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completionHandler: handleLoginResponse(success:error:))
        
    }
    
    // MARK:- Response handling
    // This method handles the completionHandler response for the POST request.
    
    func handleLoginResponse(success: Bool, error: Error?) {
        
        // When this method is called, the login process must have completed.
        // The UI elements are therefore enabled once again.
        
        self.setLoggingIn(false)
        
        // If the completionHandler from the POST request is true, the segue to the TabBar controller is run.
        
        if success {
            
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            
        } else {
            
            // If an error occurs on login. An AlertViewController is presented.
            // A customised error is passed through the network logic.
            
            showNetworkLogicFailure(title: "Login failed", message: error?.localizedDescription ?? "")
            
        }
        
    }
    
    // MARK: - Method to configure UI elements
    
    func setLoggingIn(_ loggingIn: Bool) {
        
        // If logginIn is true, then the activity indicators beings to animate.
        
        if loggingIn {
            
            loginActivityIndicator.startAnimating()
            
        } else {
            
            loginActivityIndicator.stopAnimating()
            
        }
        
        // UI elements are disabled when the login process is true.
        
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        
    }
    
    // MARK: - Alertview
    // Alert view pop-up if there is an error received on login request.
    
    func showNetworkLogicFailure(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

