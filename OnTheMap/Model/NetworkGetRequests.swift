//
//  NetworkGetRequests.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 07/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This class contains all the network GET requests.

class NetworkGetRequests {
    
    // MARK:- Generic GET request method
    // This method is called when a network GET request is required.
    // A generic type is defined as ResponseType using the Decodable protocol.
    // @escaping is defined as the network request is asynchronous.
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, udacityAdjustment: Bool, completionHandler: @escaping (ResponseType?, Error?) -> Void) {
        
        // A request is sent to the specified Endpoint.
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                
                // Specify the main thread.
                // A failure here relates to a network error.
                
                DispatchQueue.main.async {
                    completionHandler(nil, ErrorResponse.networkError)
                    
                }
                return
                
            }
            
            // Define the JSONDecoder.
            
            let decoder = JSONDecoder()
            
            // A do-catch block is run to handle the errors from decoding of the response.
            
            do {
                
                // Responses received from the Udacity API may need to adjusted before they can be parsed, where the first 5 characters are randomised for security purposes.
                // A parameter/BOOL has been specified for whether this adjustment is necessary.
                
                if udacityAdjustment {
                    let range = (5..<data.count)
                    let udacityData = data.subdata(in: range)
                    
                    // Parse the response from the network request.
                    
                    let response = try decoder.decode(ResponseType.self, from: udacityData)
                    
                    DispatchQueue.main.async {
                        completionHandler(response, nil)
                        
                    }
                    
                } else {
                    
                    let response = try decoder.decode(ResponseType.self, from: data)
                    
                    DispatchQueue.main.async {
                        completionHandler(response, nil)
                        
                    }
                    
                }
                
            } catch {
                
                // A failure here refer to a parsing error.
                
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                    
                }
                
            }
            
        }
        
        // Resume the task.
        
        task.resume()
        
    }
    
    // MARK:- Logged in user information request
    // This GET requests information for the logged in user. This information is necessary before a location may be posted.
    
    class func requestUserInformation(completionHandler: @escaping (Bool, Error?) -> Void) {
        
        // Call the generic GET request as defined above.
        
        taskForGETRequest(url: NetworkParameters.EndPoints.userInformation.url, responseType: UserInformationResponse.self, udacityAdjustment: true) { (response, error) in
            
            if let response = response {
                
                // Save the user information into the static variables defined within the NetworkParameters class.
                
                NetworkParameters.UserInformation.firstName = response.firstName
                NetworkParameters.UserInformation.lastName = response.lastName
                
                // No need to specify main thread. This is handled in the generic GET request.
                
                completionHandler(true, nil)
                
            } else {
                
                // Error type to be inferred from generic GET request. Use the debugger.
                // User is presented with a network error.
                
                completionHandler(false, ErrorResponse.networkError)
                
            }
            
        }
        
    }
    
    // MARK: - Student location information request
    // This GET requests student information used to populate the MapView and TableView. Includes information on first name, last name, coordinates and mediaURL.
    // The completion handler refers to the instance of student locations [Locations] specified in the StudentLocations class.

    class func requestStudentLocation(completionHandler: @escaping (Bool, [Locations], Error?) -> Void) {
        
        taskForGETRequest(url: NetworkParameters.EndPoints.getLocation.url, responseType: LocationResponse.self, udacityAdjustment: false) { (response, error) in
            
            if let response = response {
                
                completionHandler(true, response.results, nil)
                
            } else {
                
                // Error type to be inferred from generic GET request. Use the debugger.
                // User is presented with a network error.
                
                completionHandler(false, [], ErrorResponse.networkError)
                
            }
            
        }
        
    }
    
}
