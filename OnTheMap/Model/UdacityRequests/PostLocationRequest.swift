//
//  PostLocationRequest.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 05/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

struct PostLocationRequest: Codable {
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
//    let updatedAt: String
}
