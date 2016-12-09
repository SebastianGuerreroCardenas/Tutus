//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class EventCreationViewController: BaseViewController {
    
//    var loginClient = LoginClient()
    var eventClient = EventClient()
    var eventInfo = [String: String]()
    var isEdit = false
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var startField: UITextField!
    @IBOutlet weak var endField: UITextField!
    @IBOutlet weak var maxInvitesField: UITextField!
    @IBOutlet weak var listOpenField: UITextField!
    @IBOutlet weak var listCloseField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBAction func cancelAction(_ sender: Any) {
        if haveZeroEvents {
            let loginStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = loginStoryboard.instantiateViewController(withIdentifier: "NoEvent") as UIViewController
            present(controller, animated: true, completion: nil)

        }
        else {
            mainUser.setMainUserRole(eventID: currentEvent) {
                currentEvent = ""
                self.openViewControllerBasedOnRole(animationStyle: "fade")
            }
        }
    }
    
    
    @IBAction func createButtonTapped(sender: UIButton) {
        self.eventInfo["title"] = self.titleField.text
        self.eventInfo["location"] = self.locationField.text
        self.eventInfo["startTime"] = self.startField.text
        self.eventInfo["endTime"] = self.endField.text
        self.eventInfo["maxInvites"] = self.maxInvitesField.text
        self.eventInfo["listOpen"] = self.listOpenField.text
        self.eventInfo["listClose"] = self.listCloseField.text
        self.eventInfo["isEdit"] = String(self.isEdit)
        // if we are editing, the dictionary that was passed in also contains an eventId
        
        eventClient.setDict(diction: eventInfo) {
            self.eventClient.createEvent(){ dict in
                print(self.eventClient.dict)
                mainUser.setMainUserRole(eventID: currentEvent) {
                    currentEvent = ""
                    self.openViewControllerBasedOnRole(animationStyle: "fade")
                }
            }
        }
    }
    
    @IBAction func startFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EventCreationViewController.startFieldValueChanged), for: UIControlEvents.valueChanged)
    }
    func startFieldValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.short
        startField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func endFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EventCreationViewController.endFieldValueChanged), for: UIControlEvents.valueChanged)
    }
    func endFieldValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.short
        endField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func listOpenFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EventCreationViewController.listOpenFieldValueChanged), for: UIControlEvents.valueChanged)
    }
    func listOpenFieldValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.short
        listOpenField.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func listCloseFieldEditing(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EventCreationViewController.listCloseFieldValueChanged), for: UIControlEvents.valueChanged)
    }
    func listCloseFieldValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.timeStyle = DateFormatter.Style.short
        listCloseField.text = dateFormatter.string(from: sender.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.eventInfo.isEmpty {
            //if we are editing, populate the fields and indicate this
            self.populateFields()
            self.isEdit = true
            self.submitButton.setTitle("Edit Event",for: .normal)
            self.pageTitle.text = "Edit Event"
        }
        //self.hideKeyboardWhenTappedAround()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateFields() {
        self.titleField.text = self.eventInfo["title"]
        self.locationField.text = self.eventInfo["location"]
        self.startField.text = self.eventInfo["startTime"]
        self.endField.text = self.eventInfo["endTime"]
        self.maxInvitesField.text = self.eventInfo["maxInvites"]
        self.listOpenField.text = self.eventInfo["listOpen"]
        self.listCloseField.text = self.eventInfo["listClose"]
    }
    
}

