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
    
    func getEventOptions(completion: @escaping (([String : AnyObject]) -> Void)) {
        print("fetching event options")
        
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("http://localhost:3000/users", headers: headers).responseJSON {response in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }

        
    }
}
