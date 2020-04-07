//
//  UdacitySession.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 04/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

struct SessionRequest: Codable {
    let udacity: Udacity
}

struct Udacity: Codable {
    let username: String
    let password: String
}
