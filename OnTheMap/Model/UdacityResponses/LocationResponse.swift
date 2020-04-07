//
//  LocationResponse.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 05/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

struct LocationResponse: Codable {
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
