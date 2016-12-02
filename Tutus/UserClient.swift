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
    
    init() {

    }
    
    func setDict(dict: [String : AnyObject]) {
        self.dict = dict
    }
    
    func logOut() {
        self.dict = [:]
    }
    
//    func getEvents() ->  [Dictionary<String,String>] {
//        return ["title":"Add Event", "icon":"addIcon"]
//    }
    
    
    func createNewUser() -> Bool {
        print("did it work")
        print(self.dict)
        
        let parameters: Parameters = ["user[auth_token]": self.dict["id"] as! String, "user[full_name]": self.dict["name"] as! String, "user[email]": self.dict["email"] as! String, "user[role]": "empty"]
        
        Alamofire.request("http://riskmanapi.herokuapp.com/users",  method: .post ,parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
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
    
}
