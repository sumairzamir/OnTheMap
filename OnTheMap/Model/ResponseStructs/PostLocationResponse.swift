//
//  PostLocationResponse.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 05/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This struct maps the response from the network on a new user location.
// The response is received in a JSON format, and therefore the Codable protocol is specified.

struct PostLocationResponse: Codable {
    let createdAt: String
    let objectId: String
    
}
