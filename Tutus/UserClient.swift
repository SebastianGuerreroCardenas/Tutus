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
    
    var id: String = ""
    var name: String = ""
    
    init(userID: String, name: String) {
        self.id = userID
        self.name = name
    }
    
//    func getEvents() ->  [Dictionary<String,String>] {
//        return ["title":"Add Event", "icon":"addIcon"]
//    }
    
    func isNewUser() -> Bool {
        return true
    }
    
}
