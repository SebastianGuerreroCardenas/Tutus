//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit



class NoEventViewController: UIViewController {
    
    @IBAction func logoutAction(_ sender: Any) {
        let loginClient = LoginClient()
        loginClient.logOut()
        mainUser.logOut()
        self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "LoginController", strStoryboard: "Login")
    }
    
    @IBAction func joinAnEventAction(_ sender: Any) {
        self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventJoin", strStoryboard: "EventCreation")
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventCreation", strStoryboard: "EventCreation")
    }
    
    func openViewControllerOnIdentifierOnStoryBoard(strIdentifier: String, strStoryboard: String) {
        let loginStoryboard = UIStoryboard(name: strStoryboard, bundle: nil)
        let controller = loginStoryboard.instantiateViewController(withIdentifier: strIdentifier) as UIViewController
        
        present(controller, animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

