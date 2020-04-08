//
//  NetworkPostRequests.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 07/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This class contains all the network POST requests.

class NetworkPostRequests {
    
    // MARK:- Generic POST request method
    // This method is called when a network POST request is required.
    // Generic types are defined as RequestType using the Encodable protocol and ResponseType using the Decodable protocol.
    // @escaping is defined as the network request is asynchronous.
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType,  udacityAdjustment: Bool, completionHandler: @escaping (ResponseType?, Error?) -> Void) {
        
        // The parameters of the POST request are specified and appended to the Endpoint.
        
        var request = URLRequest(url: url)
        
        // The POST parameters specified.
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // A do-catch block is run to attempt to send the POST request.
        
        do {
            
            // The POST request is encoded into a JSON format.
            
            request.httpBody = try JSONEncoder().encode(body)
            
        } catch {
            
            // Specify the main thread.
            // A failure here relates to a encoding error.
            
            DispatchQueue.main.async {
                completionHandler(nil, error)
                
            }
            
        }
        
        // A request (JSON format) is sent to the specified Endpoint.
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                
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
                
                // ASK AIMAN IF THIS CAN BE DONE IN A CLEANER WAY
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
                
                // A failure here refers to either a parsing error or an invalid POST request.
                
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                    
                }
                
            }
            
        }
        
        // Resume the task.
        
        task.resume()
        
    }
    
    // MARK:- Post a new student location
    // This POST request sends all the information to the network necessary to save a new student location.
    
    class func postStudentLocation(
        
        // The following parameters are required by the POST request. Refer to the PostLocationRequest struct in the similarly named class.
        
        firstName: String,
        lastName: String,
        latitude: Double,
        longitude: Double,
        mapString: String,
        mediaURL: String,
        uniqueKey: String,
        
        completionHandler: @escaping (Bool, Error?) -> Void) {
        
        // Parameters for the body of the POST request are defined as per the PostLocationRequest struct.
        
        let body = PostLocationRequest(
            firstName: firstName,
            lastName: lastName,
            latitude: latitude,
            longitude: longitude,
            mapString: mapString,
            mediaURL: mediaURL,
            uniqueKey: uniqueKey
        )
        
        // Call the generic POST request as defined above.
        
        taskForPOSTRequest(url: NetworkParameters.EndPoints.postLocation.url, responseType: PostLocationResponse.self, body: body, udacityAdjustment: false) { (response, error) in
            
            if let response = response {
                
                // Save the user information into the static variables defined within the NetworkParameters class.
                // The objectId is a unique response generated once a student location is saved.
                
                NetworkParameters.UserInformation.objectId = response.objectId
                
                // No need to specify main thread. This is handled in the generic POST request.
                
                completionHandler(true, nil)
                
            } else {
                
                // Error type to be inferred from generic GET request. Use the debugger.
                // Error to the user always shown as a posting error.
                
                if let error = error as? ErrorResponse, case .networkError = error {
                    completionHandler(false, ErrorResponse.postingError)
                }
                completionHandler(false, ErrorResponse.postingError)
                
            }
            
        }
        
    }
    
    // MARK: - Login/new session network request
    // This POST requests requires a username and password, which is verified by the network. If successful, a unique sessionId is sent back.
    
    class func login(username: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
        
        // Parameters for the body of the POST request are defined as per the SessionRequest struct.
        
        let body = SessionRequest(udacity: Udacity(username: username, password: password))
        
        taskForPOSTRequest(url: NetworkParameters.EndPoints.session.url, responseType: SessionResponse.self, body: body, udacityAdjustment: true) { (response, error) in
            
            if let response = response {
                
                // Save the authorisation information into the static variables defined within the NetworkParameters class.
                
                NetworkParameters.Auth.sessionId = response.session.id
                NetworkParameters.Auth.uniqueKey = response.account.key
                
                completionHandler(true, nil)
                
            } else {
                
                // Error checking - This if-let block compares the error received from the generic POST method and provides customisation for error messages displayed to the user.
                
                if let error = error as? ErrorResponse, case .networkError = error {
                    completionHandler(false, error)
                } else {
                    completionHandler(false, ErrorResponse.authenticationError)
                }
                
            }
            
        }
        
    }
    
}
