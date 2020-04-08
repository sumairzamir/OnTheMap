//
//  NetworkLogic.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 03/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

// This class contains all the network parameters.

class NetworkParameters {
    
    // MARK:- Authorisation parameters
    // This struct manages the authentication information for the specific user session.
    
    struct Auth {
        static var sessionId = ""
        static var uniqueKey = ""
        
    }
    
    // MARK:- Logged in user information
    // This struct manages information for the specific user.
    
    struct UserInformation {
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
        
        // Default coordinates are centered around London, UK.
        
        static var latitude: Double = 51.5001524
        static var longitude: Double = -0.1262362
        
        static var mediaURL: String = ""
        static var mapString: String = ""
        
    }
    
    // MARK:- Endpoint parameters
    // This enum manages the URLs used within the network logic.
    
    enum EndPoints {
        
        // The base URL used for the Udacity API for the app
        
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        // The unique key generated on login is used for the GET request for the specific user.
        
        static let userUniqueKey = "users/\(Auth.uniqueKey)"
        
        // Optional parameters used in the GET request to download user location information. The app only specifies the order (most recent first). Limit and Skip values are taken as given from the API.
        
        static let limit = 100
        static let skip = 400
        static let order = "-updatedAt"
        
        // The specific cases for each network logic element.
        
        case session
        case getLocation
        case postLocation
        case userInformation
        
        // Definition of a String variable for each of the cases referred above.
        
        var stringValue: String {
            
            switch self {
                
            case .session:
                return EndPoints.base + "session"
            case .getLocation:
                return EndPoints.base + "StudentLocation" + "?order=\(EndPoints.order)"
            case .postLocation:
                return EndPoints.base + "StudentLocation"
            case .userInformation:
                return EndPoints.base + EndPoints.userUniqueKey
                
            }
            
        }
        
        // This converts the strings above into a URL.
        
        var url: URL {
            return URL(string: stringValue)!
            
        }
        
    }
    
}






// OLD CODE - TO DELETE


// Save old method first...duh. user infomration request.

//        var request = URLRequest(url: EndPoints.userInformation.url)
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {
//                print(error)
//                completionHandler(false, error)
//                return
//            }
//
//            let range = (5..<data.count)
//            let udacityData = data.subdata(in: range)
//
//            let decoder = JSONDecoder()
//
//            do {
//                let response = try decoder.decode(UserInformationResponse.self, from: udacityData)
//                UserInformation.firstName = response.firstName
//                UserInformation.lastName = response.lastName
//                completionHandler(true, nil)
//            } catch {
//            print(error)
//            completionHandler(false, error)
//            }
//
//        }
//
//
//        task.resume()
//
//
//    }
//
//
//
//
//class func requestStudentLocation(completionHandler: @escaping ([Locations], Error?) -> Void) {
//    var request = URLRequest(url: EndPoints.getLocation.url)
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//        guard let data = data else {
//            print(error)
//            completionHandler([],error)
//            return
//        }
//
//        let decoder = JSONDecoder()
//
//        do {
//            let response = try decoder.decode(LocationResponse.self, from: data)
//            completionHandler(response.results, nil)
//        } catch {
//            print(error)
//            completionHandler([], error)
//        }
//
//    }
//    task.resume()
//}
//
//
//
// class func postStudentLocation(
//           firstName: String,
//           lastName: String,
//           latitude: Double,
//           longitude: Double,
//           mapString: String,
//           mediaURL: String,
//           uniqueKey: String,
//           completionHandler: @escaping (Bool, Error?) -> Void) {
//
//           var request = URLRequest(url: EndPoints.postLocation.url)
//           request.httpMethod = "POST"
//           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//           let body = PostLocationRequest(
//               firstName: firstName,
//               lastName: lastName,
//               latitude: latitude,
//               longitude: longitude,
//               mapString: mapString,
//               mediaURL: mediaURL,
//               uniqueKey: uniqueKey
////               updatedAt: updatedAt
//           )
//
//           do {
//               request.httpBody = try JSONEncoder().encode(body)
//           } catch {
//               print(error)
//               completionHandler(false,error)
//           }
//
//           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//               guard let data = data else {
//                   print(error)
//                   completionHandler(false, error)
//                   return
//               }
//
//               let decoder = JSONDecoder()
//
//               do {
//
//                   let response = try decoder.decode(PostLocationResponse.self, from: data)
//                UserInformation.objectId = response.objectId
//                completionHandler(true, nil)
//               } catch {
//                   print(error)
//                   completionHandler(false, error)
//               }
//           }
//
//           task.resume()
//
//       }
//
//
////
//class func login(username: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
//
//        var request = URLRequest(url: EndPoints.session.url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let body = SessionRequest(udacity: Udacity(username: username, password: password))
//
//        do {
//            request.httpBody = try JSONEncoder().encode(body)
//        } catch {
//            print(error.localizedDescription)
//            completionHandler(false, error)
//        }
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {
//                print(error)
//                completionHandler(false, error)
//                return
//            }
//
//            let range = (5..<data.count)
//            let udacityData = data.subdata(in: range)
//
//            let decoder = JSONDecoder()
//
//            do {
//                let response = try decoder.decode(SessionResponse.self, from: udacityData)
//                Auth.sessionId = response.session.id
//                Auth.uniqueKey = response.account.key
//                print("\(Auth.sessionId)")
//                completionHandler(true, nil)
//
//            } catch {
//                print(error.localizedDescription)
//                completionHandler(false, error)
//            }
//
//        }
//        task.resume()
//    }
//
//    class func logout(completionHandler: @escaping () -> Void) {
//
//        var request = URLRequest(url: EndPoints.session.url)
//        request.httpMethod = "DELETE"
//
//        var xsrfCookie: HTTPCookie? = nil
//        let sharedCookieStorage = HTTPCookieStorage.shared
//
//        for cookie in sharedCookieStorage.cookies! {
//            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
//        }
//
//        if let xsrfCookie = xsrfCookie {
//            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
//        }
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            Auth.sessionId = ""
//            completionHandler()
//                return
//            }
//        task.resume()
//
//    }
//
//
//
//}



//    class func login(username: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
//
//            var request = URLRequest(url: EndPoints.session.url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Accept")
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            let body = SessionRequest(udacity: Udacity(username: username, password: password))
//
//            do {
//                request.httpBody = try JSONEncoder().encode(body)
//            } catch {
//                print(error.localizedDescription)
//                completionHandler(false, error)
//            }
//
//            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//                guard let data = data else {
//                    print(error)
//                    completionHandler(false, error)
//                    return
//                }
//
//                let range = (5..<data.count)
//                let udacityData = data.subdata(in: range)
//
//                let decoder = JSONDecoder()
//
//                do {
//                    let response = try decoder.decode(SessionResponse.self, from: udacityData)
//                    Auth.sessionId = response.session.id
//                    Auth.uniqueKey = response.account.key
//                    print("\(Auth.sessionId)")
//                    completionHandler(true, nil)
//
//                } catch {
//                    print(error.localizedDescription)
//                    completionHandler(false, error)
//                }
//
//            }
//            task.resume()
//        }
//
