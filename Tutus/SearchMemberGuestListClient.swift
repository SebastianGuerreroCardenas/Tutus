import Foundation
import Alamofire
import SwiftyJSON

class SearchMemberGuestListClient {
    
    func fetchRepositories(completion: @escaping (([Guest]) -> Void)) {
        let headers: HTTPHeaders = ["AuthorizationToken": mainUser.dict["id"]! as! String, "EventId": currentEvent]
        
        Alamofire.request("https://riskmanapi.herokuapp.com/invitations", headers: headers).responseJSON {response in
            
            let json = JSON(response.result.value)
            var guestList: [Guest] = []
            print("dfhasldkjfhasldkjfhasdlkjfhasldkjfhslkj")
            print(json)
            for (_,inviteUser):(String, JSON) in json {
                guestList.append(Guest(id: inviteUser["id"].stringValue, name: inviteUser["name"].stringValue, optional_title: inviteUser["optional_title"].stringValue, optional_text: inviteUser["optional_text"].stringValue, phone: inviteUser["phone"].stringValue, birthdate: inviteUser["birthdate"].stringValue, texting_consent: inviteUser["texting_consent"].stringValue, created_at: inviteUser["created_at"].stringValue))
            }
            completion(guestList)
        }
    }    
}
