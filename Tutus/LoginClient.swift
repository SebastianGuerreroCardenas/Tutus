//
//  LoginClient.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import FBSDKLoginKit
import FacebookCore

class LoginClient {
    
    var dict : [String : AnyObject]!
    
    func createNewUser(authToken: String, full_name: String, name: String, email: String, role: String) -> Bool {
        let parameters: Parameters = ["user[auth_token]": authToken, "user[full_name]": full_name, "user[email]": email, "user[role]": role]
        
        Alamofire.request("http://localhost:3000/users",  method: .post ,parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
        return true
    }
    
    func fetchProfile() {
        print("fetching profile")
        let parameters = ["fields": "id, name, first_name, last_name, email"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {(connection, result, error) -> Void in
            if error == nil {
                self.dict = result as! [String : AnyObject]
                print(result!)
                print(self.dict)
            }
        })
    }
    
    
    func isLoggedIn() -> Bool {
        if let token = FBSDKAccessToken.current() {
            return true
        }
        return false
    }
    
}
