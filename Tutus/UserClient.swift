//
//  LoginClient.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire

class UserClient {
    
    var dict: [String : AnyObject]!
    var id: String = ""
    
    init() {

    }
    
    func setDict(dict: [String : AnyObject]) {
        self.dict = dict
    }
    
    func logOut() {
        self.dict = [:]
    }
    
    func hasID() -> Bool {
        if id == "" {
            return false
        }
        else {
            return true
        }
    }
    
    
    func createNewUser() {
        print("did it work")
        print(self.dict)
        
        self.id = self.dict["id"] as! String
        
        let parameters: Parameters = ["user[auth_token]": self.dict["id"] as! String, "user[full_name]": self.dict["name"] as! String, "user[email]": self.dict["email"] as! String, "user[role]": "empty"]
        
        Alamofire.request("http://riskmanapi.herokuapp.com/users",  method: .post ,parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
}
