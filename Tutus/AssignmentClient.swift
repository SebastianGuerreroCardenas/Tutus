//
//  LocationClient.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AssignmentClient {
    
    var locations = [Location]()
    
    init() {}
    
    func getLocationsByID(completion: @escaping (([Location]) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEventObject.id]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/locations", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            var locationList: [Location] = []
            for (_,location):(String, JSON) in json {
                locationList.append(Location(id: location["id"].stringValue, event_id: location["event_id"].stringValue, description: location["description"].stringValue, name: location["name"].stringValue))
            }
            self.locations = locationList
            completion(locationList)

        }
    }
    
    func getRiskTeam(completion: @escaping (([Location]) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/locations", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            var locationList: [Location] = []
            print(json)
            for (_,location):(String, JSON) in json {
                locationList.append(Location(id: location["id"].stringValue, event_id: location["event_id"].stringValue, description: location["description"].stringValue, name: location["name"].stringValue))
            }
            completion(locationList)
            
        }
    }

    
    var dict = [String : String]()
    
    func createAssignment(completion: @escaping ((Dictionary<String,String>) -> Void)) {
        
        print("creating assignment")
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        let parameters: Parameters = ["assignment": ["event_id": currentEventObject.id, "location_id": self.dict["location_id"]! as String, "user_id": self.dict["user_id"]! as String, "start": self.dict["start"]! as String, "end": self.dict["end"]! as String, "attended": self.dict["attended"]! as String]]
            
        Alamofire.request("https://riskmanapi.herokuapp.com/assignments", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
                
            let json = JSON(response.result.value!)
                
            completion(self.dict)
        }
    }
    
    func deleteLocation(id: String, completion: @escaping (() -> Void)) {
        
        
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        
        Alamofire.request("https://riskmanapi.herokuapp.com/locations/" + id,  method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            
            completion()
        }
        
    }
    
    func setDict(diction: [String : String] , completion: @escaping (() -> Void)) {
        self.dict = diction
        completion()
    }
    
    func deleteAssignment(id: String, completion: @escaping (() -> Void)) {
        
        
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        
        Alamofire.request("https://riskmanapi.herokuapp.com/assignments/" + id,  method: .delete, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value!)
            
            completion()
        }
        
    }
    
    func fetchRepositories(completion: @escaping (([Assignment]) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/assignments", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value)
            var assignmentList: [Assignment] = []
            print(json)
            for (_,assignment):(String, JSON) in json {
                assignmentList.append(Assignment(id: assignment["id"].stringValue, location_id: assignment["location_id"].stringValue, user_id: assignment["user_id"].stringValue, start: assignment["start"].stringValue, end: assignment["end"].stringValue))
            }
            completion(assignmentList)
        }
    }
    
}


