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

class QuestionClient {
    

    

    
    func submitData(questionId: String, response: String, completion: @escaping (() -> Void)) {
        print("creating event user")
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
        
        let parameters: Parameters = ["data": ["user_id": mainUser.userObject.id, "event_id": currentEvent, "question_id": questionId, "response": response]]
        
        
        Alamofire.request("https://riskmanapi.herokuapp.com/events", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            
            
            completion()
        }
    }
    
    //needs testing
    func getQuestion(completion: @escaping ((Question) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/questions", headers: headers).responseJSON {response in
            let json = JSON(response.result.value!)
            
            let question: Question = Question(id: json["id"].stringValue , question: json["question"].stringValue )
            
            completion(question)
        }
    }
    
    
    
}
