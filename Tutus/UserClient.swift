//
//  LoginClient.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserClient {
    
    var dict = [String : AnyObject]()
    var id: String = ""
    var userObject: User!
    
    init() {

    }
    
    func setDict(dict: [String : AnyObject]) {
        self.dict = dict
    }
    
    func logOut() {
        self.dict = [:]
        self.id = ""
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
            print("create new user")
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
    func getEventUsersByAuthToken(completion: @escaping ((User) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/getuser", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            
            let user = User(id: json["id"].stringValue, role: "", email: json["email"].stringValue, full_name: json["full_name"].stringValue, auth_token: json["auth_token"].stringValue, created_at: json["created_at"].stringValue)
            
            completion(user)
        }
    }
    
    //needs testing
    func setMainUserRole(eventID: String, completion: @escaping (() -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": eventID]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/event_users", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            print(json)
            
            for (_,eventUser):(String, JSON) in json {
                if eventUser["user_id"].stringValue == mainUser.userObject.id  && eventUser["event_id"].stringValue == eventID{
                    mainUser.userObject.role = eventUser["role"].stringValue
                }
            }
            completion()
        }
    }
    
    
    
}
