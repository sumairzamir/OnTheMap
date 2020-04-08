//
//  ErrorDescriptions.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 07/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This struct maps customised Error responses to be presented to the user.
// LocalisedError allows addition of customised Errors. Equatable allows parameters to be compared.

enum ErrorResponse: LocalizedError, Equatable {
    case networkError
    case authenticationError
    case geocodeError
    case postingError
    
    var errorDescription: String? {
    
        switch self {
            
        // These error descriptions are called in the Network requests.
        
        case .networkError: return "A network error has occurred. Reset your network setting and try again."
        case .authenticationError: return "Email or password is incorrect. Re-enter your sign-in details."
        case .geocodeError: return "The location was not found. Re-enter a valid location."
        case .postingError: return "Unable to post location. Try again later."
        
        }
        
    }
    
}
