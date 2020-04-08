//
//  UdacitySessionResponse.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 04/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// These structs map the response from the network on login request.
// The response is received in a JSON format, and therefore the Codable protocol is specified.

struct SessionResponse: Codable {
    
    // The JSON response includes keys within keys, i.e. the account key includes a registered and key "key".
    // To map nested keys, the type specified should refer to new structs as below.
    
    let account: Account
    let session: Session

}

struct Account: Codable {
    let registered: Bool
    let key: String
    
}

struct Session: Codable {
    let id: String
    let expiration: String

}
