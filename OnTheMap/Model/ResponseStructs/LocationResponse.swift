//
//  LocationResponse.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 05/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// These structs map the response from the network on student location information.
// The response is received in a JSON format, and therefore the Codable protocol is specified.

struct LocationResponse: Codable {
    
    // The results key, has been specified with an array which is called in the instance defined in the StudentLocations class.
    
    let results: [Locations]
    
}

struct Locations: Codable {
    let createdAt: String
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let objectId: String
    let uniqueKey: String
    let updatedAt: String
    
}
