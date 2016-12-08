//
//  GuestClient.swift
//  Tutus
//
//  Created by Mark Vella on 12/4/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GuestClient {
    
    init() {
        
    }
    
    var dict = [String : String]()
    
    func createGuest(completion: @escaping ((Dictionary<String,String>) -> Void)) {
        if dict["isEdit"] == "true" {
            print("editing guest")
            let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEventObject.id]
            let parameters: Parameters = ["guest": ["name": self.dict["name"]! as String, "optional_title": self.dict["optionalTitle"]! as String, "optional_text": self.dict["optionalText"]! as String, "phone": self.dict["phone"]! as String, "birthdate": self.dict["birthdate"]! as String]]
            let urlForRequest = "https://riskmanapi.herokuapp.com/guests/" + self.dict["GuestId"]!
            
            Alamofire.request(urlForRequest, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                
                _ = JSON(response.result.value!)
                
                completion(self.dict)
            }
        }
        else {
            print("creating guest")
            let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEventObject.id]
            let parameters: Parameters = ["guest": ["name": self.dict["name"]! as String, "optional_title": self.dict["optionalTitle"]! as String, "optional_text": self.dict["optionalText"]! as String, "phone": self.dict["phone"]! as String, "birthdate": self.dict["birthdate"]! as String]]
            
            Alamofire.request("https://riskmanapi.herokuapp.com/guests", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                
                //let json = JSON(response.result.value!)
                
                completion(self.dict)
            }
        }
    }
    
    
    func checkGuestIntoEvent(checkIn: Bool, guest: Guest ,completion: @escaping(() -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEventObject.id, "guestId": guest.id]
        let url: String!
        if checkIn {
            url = "https://riskmanapi.herokuapp.com/check_ins"
        }
        else {
            url = "https://riskmanapi.herokuapp.com/check_outs"
        }
        let parameters: Parameters = [:]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            completion()
        }
        

    }
    
    func deleteGuest(id: String, completion: @escaping (() -> Void)) {
        
        
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        
        Alamofire.request("https://riskmanapi.herokuapp.com/guests/" + id,  method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            
            completion()
        }
        
    }
    
    func setDict(diction: [String : String] , completion: @escaping (() -> Void)) {
        self.dict = diction
        completion()
    }

    
}
