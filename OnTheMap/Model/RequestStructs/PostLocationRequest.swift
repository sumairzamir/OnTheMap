//
//  PostLocationRequest.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 05/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This structs maps the request to the network on posting a new user location.
// The request is sent in a JSON format, and therefore the Codable protocol is specified.

struct PostLocationRequest: Codable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    
}
