//
//  ViewController.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 31/03/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: ButtonParameters!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: Any) {
    
        setLoggingIn(true)
        
        NetworkLogic.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completionHandler: handleLoginResponse(success:error:))
    
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        
        DispatchQueue.main.async {
            self.setLoggingIn(false)
        }
        
        if success {
            print(NetworkLogic.Auth.sessionId)
            
            //Move once ready to refactor code
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        } else {
            print(error)
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            loginActivityIndicator.startAnimating()
        } else {
            loginActivityIndicator.stopAnimating()
            
        }
        
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        
    }
    

}

