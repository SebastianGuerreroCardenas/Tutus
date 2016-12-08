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

class MessageClient {
    
    //needs testing
    func sendMessage(message: String, completion: @escaping (() -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
        //notsure
        Alamofire.request("https://riskmanapi.herokuapp.com/message", headers: headers).responseJSON {response in
            let json = JSON(response.result.value)
            
            
            completion()
        }
    }
    
    
    
}
