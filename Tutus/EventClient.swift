//
//  GuestListClient.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/24/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EventClient {
    
    var dict = [String : String]()
    
    func createEvent(completion: @escaping ((Dictionary<String,String>) -> Void)) {
        if dict["isEdit"] == "true" {
            print("editing event")
            let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
            let parameters: Parameters = ["event": ["title": self.dict["title"]! as String, "location": self.dict["location"]! as String, "start": self.dict["startTime"]! as String, "end": self.dict["endTime"]! as String, "max_attendance": self.dict["maxInvites"]! as String, "time_to_send_invites": self.dict["listOpen"]! as String, "list_close": self.dict["listClose"]! as String]]
            let urlForRequest = "https://riskmanapi.herokuapp.com/events/" + self.dict["eventId"]!
            
            Alamofire.request(urlForRequest, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                
                let json = JSON(response.result.value!)
                
                completion(self.dict)
            }
        }
        else {
            print("creating event")
            let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
            let parameters: Parameters = ["event": ["title": self.dict["title"]! as String, "location": self.dict["location"]! as String, "start": self.dict["startTime"]! as String, "end": self.dict["endTime"]! as String, "max_attendance": self.dict["maxInvites"]! as String, "time_to_send_invites": self.dict["listOpen"]! as String, "list_close": self.dict["listClose"]! as String]]
        
            Alamofire.request("https://riskmanapi.herokuapp.com/events", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
                let json = JSON(response.result.value!)
                
                newEvent = json["id"].stringValue
                
                completion(self.dict)
            }
        }
    }
    
    func setDict(diction: [String : String] , completion: @escaping (() -> Void)) {
        self.dict = diction
        completion()
    }
    
    func createEventUser(completion: @escaping ((Dictionary<String,String>) -> Void)) {
        print("creating event user")
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "InviteCode": self.dict["invite"]!]
            
        Alamofire.request("https://riskmanapi.herokuapp.com/event_users", method: .post, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                
            let json = JSON(response.result.value!)
            newEvent = json["event_id"].stringValue
            completion(self.dict)
        }
    }

    
    func getEventByID(completion: @escaping ((Event) -> Void)) {
        print("fetching event options")
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/events/" + currentEvent, headers: headers).responseJSON {response in
    
            let json = JSON(response.result.value!)
    
            let event = Event(id: json["id"].stringValue, title: json["title"].stringValue, location: json["location"].stringValue, start: json["start"].stringValue, end: json["end"].stringValue, max_attendance: json["max_attendance"].stringValue, time_to_send_invites: json["time_to_send_invites"].stringValue, list_close:  json["list_close"].stringValue, created_at: json["created_at"].stringValue, admin_invite_code: json["admin_invite_code"].stringValue, team_invite_code:  json["team_invite_code"].stringValue, member_invite_code: json["member_invite_code"].stringValue, event_role: "", event_users: [])
            
            completion(event)
        }
    }


 //   func getUsersByID(userID: String, role: String,completion: @escaping ((User) -> Void)) {
 //       let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
 //
 //       Alamofire.request("https://riskmanapi.herokuapp.com/users/" + userID, headers: headers).responseJSON {response in
            
//            let json = JSON(response.result.value!)

//            let user = User(id: json["id"].stringValue, role: role, email: json["email"].stringValue, full_name: json["full_name"].stringValue, auth_token: json["auth_token"].stringValue, created_at: json["created_at"].stringValue)

//            completion(user)
//        }
//    }
    
    //needs testing
    func getEventUsers(completion: @escaping (([User]) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/geteventuserobjects", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            var userList: [User] = []
            
            for (_,user):(String, JSON) in json {
                print("PLEASE GOD MAKE THIS WORK" + user["email"].stringValue)
                userList.append(User(id: user["id"].stringValue, role: user["role"].stringValue, email: user["email"].stringValue ,full_name: user["full_name"].stringValue, auth_token: user["auth_token"].stringValue ,created_at: user["created_at"].stringValue))
            }
            completion(userList)
        }
    }

}
