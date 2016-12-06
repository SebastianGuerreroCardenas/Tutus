//
//  MenuViewClient.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 12/2/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MenuViewClient {
    init() {
        
    }
    
    func getEventOptions(completion: @escaping (([Dictionary<String,String>]) -> Void)) {
        print("fetching event options")
        var eventOptions = [Dictionary<String,String>]()
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/events", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value)
            for (_,event):(String, JSON) in json {
                eventOptions.append(["title": event["title"].stringValue, "icon":"partyIcon", "id": event["id"].stringValue])
            }
            completion(eventOptions)
        }
    }
    
    func getEventCount(completion: @escaping ((Int, String) -> Void)) {
        print("fetching event options")
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/events", headers: headers).responseJSON {response in
            let json: JSON = JSON(response.result.value)
            var firstID:String = ""
            if (json.count != 0) {
                firstID = json[0]["id"].stringValue
            }
            completion(json.count, firstID)
        }
    }
}
