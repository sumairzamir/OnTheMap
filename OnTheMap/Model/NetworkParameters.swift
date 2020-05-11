//
//  NetworkLogic.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 03/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This class contains all the network parameters.

class NetworkParameters {
    
    // MARK:- Authorisation parameters
    // This struct manages the authentication information for the specific user session.
    
    struct Auth {
        static var sessionId = ""
        static var uniqueKey = ""
        
    }
    
    // MARK:- Logged in user information
    // This struct manages information for the specific user.
    
    struct UserInformation {
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
        
        // Default coordinates are centered around London, UK.
        
        static var latitude: Double = 51.5001524
        static var longitude: Double = -0.1262362
        
        static var mediaURL: String = ""
        static var mapString: String = ""
        
    }
    
    // MARK:- Endpoint parameters
    // This enum manages the URLs used within the network logic.
    
    enum EndPoints {
        
        // The base URL used for the Udacity API for the app
        
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        // The unique key generated on login is used for the GET request for the specific user.
        
        static let userUniqueKey = "users/\(Auth.uniqueKey)"
        
        // Optional parameters used in the GET request to download user location information. The app only specifies the order (most recent first). Limit and Skip values are taken as given from the API.
        
        static let limit = 100
        static let skip = 400
        static let order = "-updatedAt"
        
        // The specific cases for each network logic element.
        
        case session
        case getLocation
        case postLocation
        case userInformation
        
        // Definition of a String variable for each of the cases referred above.
        
        var stringValue: String {
            
            switch self {
                
            case .session:
                return EndPoints.base + "session"
            case .getLocation:
                return EndPoints.base + "StudentLocation" + "?order=\(EndPoints.order)" + "&limit=\(EndPoints.limit)"
            case .postLocation:
                return EndPoints.base + "StudentLocation"
            case .userInformation:
                return EndPoints.base + EndPoints.userUniqueKey
                
            }
            
        }
        
        // This converts the strings above into a URL.
        
        var url: URL {
            return URL(string: stringValue)!
            
        }
        
    }
    
}
