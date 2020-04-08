//
//  NetworkDeleteRequests.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 07/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This class contains all the network DELETE requests.
// A generic DELETE request has not been created as there is only a single DELETE/logout requirement.

class NetworkDeleteRequests {
    
    // MARK:- Logout/session end request
    // This DELETE request ends the user session and eliminates the sessionId.
    
    class func logout(completionHandler: @escaping () -> Void) {
        
        // The parameters of the DELETE request are specified and appended to the Endpoint.
        
        var request = URLRequest(url: NetworkParameters.EndPoints.session.url)
        
        // The DELETE request is specified.
        
        request.httpMethod = "DELETE"
        
        // Cookie related parameters are specified.
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        
        for cookie in sharedCookieStorage.cookies! {
            
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
            
        }
        
        if let xsrfCookie = xsrfCookie {
            
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
            
        }
        
        // A request is sent to the specified Endpoint.
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // The saved sessionId is removed from the static variable defined in the NetworkParameters class.
            
            NetworkParameters.Auth.sessionId = ""
            
            DispatchQueue.main.async {
                completionHandler()
                
            }
            
            return
            
        }
        
        // Resume the task.
        
        task.resume()
        
    }
    
}
