//
//  UserInformationResponse.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 06/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// These structs map the response from the network on logged in user information.
// The response is received in a JSON format, and therefore the Codable protocol is specified.

struct UserInformationResponse: Codable {
    let firstName: String
    let lastName: String
    
    // The JSON response is not in a swift format. These are mapped using the CodingKey protocol as below.
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        
    }
    
}
