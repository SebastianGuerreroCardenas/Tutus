//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit



class NoEventViewController: BaseViewController {
    
    // MARK: IB ACTIONS
    @IBAction func logoutAction(_ sender: Any) {
        let loginClient = LoginClient()
        loginClient.logOut()
        mainUser.logOut()
        self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "LoginController", strStoryboard: "Login", animationStyle: "")
    }
    
    @IBAction func joinAnEventAction(_ sender: Any) {
        self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventJoin", strStoryboard: "EventCreation", animationStyle: "")
    }
    
    @IBAction func createEventAction(_ sender: Any) {
        self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventCreation", strStoryboard: "EventCreation", animationStyle: "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //CHECK THIS MARK, I MADE IT OVERRIDE
    override func openViewControllerOnIdentifierOnStoryBoard(strIdentifier: String, strStoryboard: String, animationStyle: String) {
        let loginStoryboard = UIStoryboard(name: strStoryboard, bundle: nil)
        let controller = loginStoryboard.instantiateViewController(withIdentifier: strIdentifier) as UIViewController
        
        present(controller, animated: true, completion: nil)
        
    }
    
    
}

