//
//  BaseViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit
var currentEvent = ""
var newEvent = ""
var currentEventObject: Event!
var mainUser = UserClient()
var haveZeroEvents: Bool = false

class BaseViewController: UIViewController, SlideMenuDelegate {
    
    // MARK: Properties & Outlets
    var loginClient = LoginClient()
    var menuViewClient = MenuViewClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fhasdkljfhasdkjfhasdlkjfhasdlkjfhsadkjfhsakldjfhlkj")
        // Do any additional setup after loading the view.
        
        // checks if client is logged in, if they arent they are taken to the login page.
        if !loginClient.isLoggedIn(){
            print("is not logged in")
            let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let controller = loginStoryboard.instantiateViewController(withIdentifier: "LoginController") as UIViewController
            present(controller, animated: true, completion: nil)
        }
        else {
            //if they are logged the mainUser global varible is not set up, it will generate the data for it
            if !mainUser.hasID() {
                loginClient.getData(){ dict in
                    mainUser.setDict(dict: self.loginClient.dictionary())
                    // if they are a new user it will add the person to the database, if not it will fail to create it.
                    mainUser.createNewUser()
                    mainUser.getEventUsersByAuthToken() { user in
                        mainUser.userObject = user
                    }
                    //checks if the user has any events, if they are a user with no events they are taken to the NoEvent storyboard
                    self.menuViewClient.getEventCount { count, id in
                        print(count)
                        print(currentEvent)
                        if count == 0 {
                            haveZeroEvents = true
                            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = loginStoryboard.instantiateViewController(withIdentifier: "NoEvent") as UIViewController
                            self.present(controller, animated: true, completion: nil)
                        }
                        else if (count != 0 && newEvent == "") {
                            haveZeroEvents = false
                            newEvent = id
                            //here is where you get the role of the user for that event and pick where to go
                            mainUser.setMainUserRole(eventID: newEvent) {
                                print("THIS IS ME HERE")
                                print(mainUser.userObject.role)
                                self.openViewControllerBasedOnRole(animationStyle: "fade")
                            }
                            //self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventMain", strStoryboard: "Event", animationStyle: "fade")
                        }
                    }
                }
            }
            else {
                if !mainUser.hasID() {
                    loginClient.getData(){ dict in
                        mainUser.setDict(dict: self.loginClient.dictionary())
                        // if they are a new user it will add the person to the database, if not it will fail to create it.
                        mainUser.createNewUser()
                        mainUser.getEventUsersByAuthToken() { user in
                            mainUser.userObject = user
                        }
                        //checks if the user has any events, if they are a user with no events they are taken to the NoEvent storyboard
                        self.menuViewClient.getEventCount { count, id in
                           
                            if count == 0 {
                                haveZeroEvents = true
                                let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let controller = loginStoryboard.instantiateViewController(withIdentifier: "NoEvent") as UIViewController
                                self.present(controller, animated: true, completion: nil)
                            }
                            else if (count != 0 && newEvent == "") {
                                haveZeroEvents = false
                                newEvent = id
                                mainUser.setMainUserRole(eventID: newEvent) {
                                    print("THIS IS ME HERE")
                                    print(mainUser.userObject.role)
                                    self.openViewControllerBasedOnRole(animationStyle: "fade")
                                }

                            }
                        }
                    }
                }
            }
        }


        
    }
    
//    func authFunction() {
//        if !mainUser.hasID() {
//            loginClient.getData(){ dict in
//                mainUser.setDict(dict: self.loginClient.dictionary())
//                // if they are a new user it will add the person to the database, if not it will fail to create it.
//                mainUser.createNewUser()
//                mainUser.getEventUsersByAuthToken() { user in
//                    mainUser.userObject = user
//                }
//                //checks if the user has any events, if they are a user with no events they are taken to the NoEvent storyboard
//                self.menuViewClient.getEventCount { count, id in
//                    print(count)
//                    print(currentEvent)
//                    if count == 0 {
//                        haveZeroEvents = true
//                        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                        let controller = loginStoryboard.instantiateViewController(withIdentifier: "NoEvent") as UIViewController
//                        self.present(controller, animated: true, completion: nil)
//                    }
//                    else if (count != 0 && newEvent == "") {
//                        haveZeroEvents = false
//                        newEvent = id
//                        //here is where you get the role of the user for that event and pick where to go
//                        mainUser.setMainUserRole(eventID: newEvent) {
//                            print("THIS IS ME HERE")
//                            print(mainUser.userObject.role)
//                            self.openViewControllerBasedOnRole(animationStyle: "fade")
//                        }
//                        //self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventMain", strStoryboard: "Event", animationStyle: "fade")
//                    }
//                }
//            }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int32, label: String, id: String) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        print(label)
        if label == "Log Out" {
            let loginClient = LoginClient()
            loginClient.logOut()
            mainUser.logOut()
            self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "LoginController", strStoryboard: "Login", animationStyle: "")
        }
        else if label == "Create Event" {
            self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventCreation", strStoryboard: "EventCreation", animationStyle: "")
        }
        else if label == "Join Event" {
            self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventInvite", strStoryboard: "EventInvite", animationStyle: "")
        }
        else if label == "Already there" {
            print("Nothing Happens")
        }
        else {
            //here is where you get the role of the user for that event and pick where to go
            newEvent = id
            mainUser.setMainUserRole(eventID: newEvent) {
                self.openViewControllerBasedOnRole(animationStyle: "fade")
            }
            //self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "EventMain", strStoryboard: "Event", animationStyle: "")
        }
    }
    
    
    func openViewControllerOnIdentifierOnStoryBoard(strIdentifier: String, strStoryboard: String, animationStyle: String) {
        let loginStoryboard = UIStoryboard(name: strStoryboard, bundle: nil)
        let controller = loginStoryboard.instantiateViewController(withIdentifier: strIdentifier) as UIViewController
        
        if strStoryboard == "Login" || strStoryboard == "EventCreation" || strStoryboard == "GuestCreation" || strStoryboard == "EventInvite" {
            present(controller, animated: true, completion: nil)
        }
        
        if currentEvent == newEvent {
            print("same")
        }
        else {
            //source: http://stackoverflow.com/questions/37722323/how-to-present-view-controller-from-right-to-left-in-ios-using-swift
            if animationStyle == "fade" {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionFade
                transition.subtype = kCATransitionFromRight
                view.window!.layer.add(transition, forKey: kCATransition)
            }
            else {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                view.window!.layer.add(transition, forKey: kCATransition)
            }
            present(controller, animated: false, completion: nil)
        }
        
    }
    
    //function in progress
    func openViewControllerBasedOnRole(animationStyle: String) {
        var strIdentifier:String = ""
        var strStoryboard:String = ""
        if mainUser.userObject.role == "Admin"{
            strIdentifier = "EventMain"
            strStoryboard = "Event"
        }
        else if mainUser.userObject.role == "Team" {
            strIdentifier = "EventTeam"
            strStoryboard = "EventTeam"
            
        }
        else if mainUser.userObject.role == "Member"{
            strIdentifier = "EventMember"
            strStoryboard = "EventMember"
        }
        self.openViewControllerOnIdentifierOnStoryBoard(strIdentifier: strIdentifier, strStoryboard: strStoryboard, animationStyle: animationStyle)

    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addSlideManuButtonOnStoryboard(storyBoard: String,completion: @escaping (() -> Void)) {
        completion()
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
        UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return defaultMenuImage;
    }
    
    func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1, label: "Already there", id: "alreadythere");
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
}
