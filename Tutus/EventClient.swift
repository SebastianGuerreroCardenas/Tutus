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
    
    init() {
        
    }
    
    func getEventByID(completion: @escaping ((Dictionary<String,String>) -> Void)) {
        print("fetching event options")
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/events/" + currentEvent, headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value)
            var event: Dictionary<String,String> = ["title": json["title"].stringValue, "location": json["location"].stringValue, "id": json["id"].stringValue, "start": json["start"].stringValue , "end": json["end"].stringValue , "max_attendance": json["max_attendance"].stringValue, "time_to_send_invites": json["time_to_send_invites"].stringValue, "list_close": json["list_close"].stringValue, "admin_invite_code": json["admin_invite_code"].stringValue, "team_invite_code": json["team_invite_code"].stringValue, "member_invite_code": json["member_invite_code"].stringValue]
            
            
            completion(event)
        }
        
        
    }
}
