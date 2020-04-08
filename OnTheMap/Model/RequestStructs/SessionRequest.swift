//
//  UdacitySession.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 04/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// These structs map the request to the network on login.
// The request is sent in a JSON format, and therefore the Codable protocol is specified.

struct SessionRequest: Codable {
    
    // The JSON response includes keys within keys, i.e. the udacity key includes a username and password "key".
    // To map nested keys, the type specified should refer to new structs as below.
    
    let udacity: Udacity
    
}

struct Udacity: Codable {
    let username: String
    let password: String
    
}
