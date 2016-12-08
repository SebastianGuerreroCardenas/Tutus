import Foundation
import Alamofire
import SwiftyJSON

class SearchGuestListRiskClient {
    func fetchRepositories(_ completion: @escaping ([Guest]) -> Void) {
        
        let urlString = "https://riskmanapi.herokuapp.com/guests"
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]

    
        Alamofire.request(urlString, headers: headers).responseJSON {response in
            let json = JSON(response.result.value)
            var guestList: [Guest] = []
            print(json)
            for (index,guest):(String, JSON) in json {
                guestList.append(Guest(id: guest["id"].stringValue, name: guest["name"].stringValue, optional_title: guest["optional_title"].stringValue, optional_text: guest["optional_text"].stringValue, phone: guest["phone"].stringValue, birthdate: guest["birthdate"].stringValue, texting_consent: guest["texting_consent"].stringValue, created_at: guest["created_at"].stringValue))
            }
            completion(guestList)
        }
        
    }
}
