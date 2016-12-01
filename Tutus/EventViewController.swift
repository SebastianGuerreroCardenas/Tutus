//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController {
    
    var loginClient = LoginClient()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if !loginClient.isLoggedIn(){
            print("is not logged in")
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let controller = loginStoryboard.instantiateViewController(withIdentifier: "LoginController") as UIViewController
            present(controller, animated: true, completion: nil)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

