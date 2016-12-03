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
    
    var dict: [String : AnyObject] = ["Empty": "Empty" as AnyObject]
    
    init() {
        if self.isLoggedIn() {
            fetchProfile()
        }
    }
    
    
    func fetchProfile() {
        print("fetching profile")
        let parameters = ["fields": "id, name, first_name, last_name, email"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {(connection, result, error) -> Void in
            if error == nil {
                self.dict = result as! [String : AnyObject]
                //print(result!)
                //print(self.dict)
            }
            
        })
    }
    
    func getData(completion: @escaping (([String : AnyObject]) -> Void)) {
        print("fetching profile")
        let parameters = ["fields": "id, name, first_name, last_name, email"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {(connection, result, error) -> Void in
            if error == nil {
                self.dict = result as! [String : AnyObject]
                //print(result!)
                //print(self.dict)
                completion(self.dict)
            }
            
        })
    }
    
    func logOut() {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
    }
    
    func name() -> String {
        if let name = self.dict["name"] {
            return name as! String
        }
        else {
            return "nil"
        }
    }
    
    func id() -> String {
        if let id = self.dict["id"] {
            return id as! String
        }
        else {
            return "nil"
        }
    }
    
    func dictionary() -> [String : AnyObject] {
        return self.dict
    }
    
    func isLoggedIn() -> Bool {
        if let token = FBSDKAccessToken.current() {
            return true
        }
        return false
    }
    
}
