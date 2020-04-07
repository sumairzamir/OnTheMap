//
//  UdacitySessionResponse.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 04/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
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

