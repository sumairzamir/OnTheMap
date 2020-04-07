//
//  NetworkLogic.swift
//  OnTheMap
//
//  Created by Sumair Zamir on 03/04/2020.
//  Copyright © 2020 Sumair Zamir. All rights reserved.
//

import Foundation

class NetworkLogic {
    
    struct Auth {
        static var sessionId = ""
        static var limit = 100
        static var skip = 400
        static var order = "-updatedAt"
        static var uniqueKey = ""
        static var objectId = ""
        static var firstName = ""
        static var lastName = ""
    }
    
    enum EndPoints {
        static let base = "https://onthemap-api.udacity.com/v1/"
        static let userUniqueKey = "users/\(Auth.uniqueKey)"
        
        case session
        case getLocation
        case postLocation
        case userInformation
        
        var stringValue: String {
            
            switch self {
            case .session:
                return EndPoints.base + "session"
            case .getLocation:
                return EndPoints.base + "StudentLocation" + "?order=\(Auth.order)"
            case .postLocation:
                return EndPoints.base + "StudentLocation"
            case .userInformation:
                return EndPoints.base + EndPoints.userUniqueKey
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    class func requestUserInformation(completionHandler: @escaping (Bool, Error?) -> Void) {
        var request = URLRequest(url: EndPoints.userInformation.url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(error)
                completionHandler(false, error)
                return
            }
            
            let range = (5..<data.count)
            let udacityData = data.subdata(in: range)
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(UserInformation.self, from: udacityData)
                Auth.firstName = response.firstName
                Auth.lastName = response.lastName
                completionHandler(true, nil)
            } catch {
            print(error)
            completionHandler(false, error)
            }
            
        }
        
        
        task.resume()
        
        
    }
    
    class func requestStudentLocation(completionHandler: @escaping ([Locations], Error?) -> Void) {
        var request = URLRequest(url: EndPoints.getLocation.url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(error)
                completionHandler([],error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(LocationResponse.self, from: data)
                completionHandler(response.results, nil)
            } catch {
                print(error)
                completionHandler([], error)
            }
            
        }
        task.resume()
    }
    
    class func postStudentLocation(
           firstName: String,
           lastName: String,
           latitude: Double,
           longitude: Double,
           mapString: String,
           mediaURL: String,
           uniqueKey: String,
           completionHandler: @escaping (Bool, Error?) -> Void) {
    
           var request = URLRequest(url: EndPoints.postLocation.url)
           request.httpMethod = "POST"
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
           let body = PostLocationRequest(
               firstName: firstName,
               lastName: lastName,
               latitude: latitude,
               longitude: longitude,
               mapString: mapString,
               mediaURL: mediaURL,
               uniqueKey: uniqueKey
//               updatedAt: updatedAt
           )
    
           do {
               request.httpBody = try JSONEncoder().encode(body)
           } catch {
               print(error)
               completionHandler(false,error)
           }
    
           let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               guard let data = data else {
                   print(error)
                   completionHandler(false, error)
                   return
               }
    
               let decoder = JSONDecoder()
    
               do {
    
                   let response = try decoder.decode(PostLocationResponse.self, from: data)
                Auth.objectId = response.objectId
                completionHandler(true, nil)
               } catch {
                   print(error)
                   completionHandler(false, error)
               }
           }
    
           task.resume()
    
       }
    
    
    
    
    
    
    // MARK: - LOGIN & LOGOUT LOGIC - COMPLETE
    
    class func login(username: String, password: String, completionHandler: @escaping (Bool, Error?) -> Void) {
        
        var request = URLRequest(url: EndPoints.session.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = SessionRequest(udacity: Udacity(username: username, password: password))
        
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            print(error)
            completionHandler(false, error)
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(error)
                completionHandler(false, error)
                return
            }
            
            let range = (5..<data.count)
            let udacityData = data.subdata(in: range)
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(SessionResponse.self, from: udacityData)
                Auth.sessionId = response.session.id
                Auth.uniqueKey = response.account.key
                print("\(Auth.sessionId)")
                completionHandler(true, nil)
                
            } catch {
                print(error)
                completionHandler(false, error)
            }
            
        }
        task.resume()
    }
    
    class func logout(completionHandler: @escaping () -> Void) {
        
        var request = URLRequest(url: EndPoints.session.url)
        request.httpMethod = "DELETE"
        
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            Auth.sessionId = ""
            completionHandler()
                return
            }   
        task.resume()
        
    }
    
    
    
}




