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
    
            let json = JSON(response.result.value)
    
            let event = Event(id: json["id"].stringValue, title: json["title"].stringValue, location: json["location"].stringValue, start: json["start"].stringValue, end: json["end"].stringValue, max_attendance: json["max_attendance"].stringValue, time_to_send_invites: json["time_to_send_invites"].stringValue, list_close:  json["list_close"].stringValue, created_at: json["created_at"].stringValue, admin_invite_code: json["admin_invite_code"].stringValue, team_invite_code:  json["team_invite_code"].stringValue, member_invite_code: json["member_invite_code"].stringValue, event_role: "")
            
            completion(event)
        }
    }


    func getUsersByID(userID: String, role: String,completion: @escaping ((User) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/users/" + userID, headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value)
            
            let user = User(id: json["id"].stringValue, role: role, email: json["email"].stringValue, full_name: json["full_name"].stringValue, auth_token: json["auth_token"].stringValue, created_at: json["created_at"].stringValue)

            completion(user)
        }
    }
    
    //needs testing
    func getEventUsers(completion: @escaping (([User]) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/event_users", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value)
            var userList: [User] = []
            
            for (_,eventUser):(String, JSON) in json {
                self.getUsersByID(userID: eventUser["id"].stringValue, role: eventUser["role"].stringValue) {user in
                    userList.append(user)
                }
            }
            
            completion(userList)
        }
    }
    
    
    //needs testing
//    func getInviteGuests(completion: @escaping (([Guest]) -> Void)) {
//        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
//        
//        Alamofire.request("https://riskmanapi.herokuapp.com/event_users", headers: headers).responseJSON {response in
//            
//            let json = JSON(response.result.value)
//            var guestList: [Guest] = []
//            
//            for (_,inviteUser):(String, JSON) in json {
//                guestList.append(Guest(id: inviteUser["id"].stringValue, name: inviteUser["name"].stringValue, optional_title: inviteUser["optional_title"].stringValue, optional_text: inviteUser["optional_text"].stringValue, phone: inviteUser["phone"].stringValue, birthdate: inviteUser["birthdate"].stringValue, texting_consent: inviteUser["texting_consent"].stringValue, created_at: inviteUser["created_at"].stringValue))
//            }
//            completion(guestList)
//        }
//    }


}
