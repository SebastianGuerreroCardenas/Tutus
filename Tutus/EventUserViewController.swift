//
//  EventUserViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class EventUserViewController: BaseViewController {

//    var loginClient = LoginClient()
    var eventClient = EventClient()
    var inviteInfo = [String: String]()
    
    @IBOutlet weak var inviteCodeField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    @IBAction func submitButtonTapped(sender: UIButton) {
        self.inviteInfo["invite"] = self.inviteCodeField.text
        
        eventClient.setDict(diction: inviteInfo) {
            self.eventClient.createEventUser(){ dict in
                print(self.eventClient.dict)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if !loginClient.isLoggedIn(){
//            print("is not logged in")
//            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
//            let controller = loginStoryboard.instantiateViewController(withIdentifier: "LoginController") as UIViewController
//            present(controller, animated: true, completion: nil)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
