//
//  LocationCreationViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class LocationCreationViewController: BaseViewController {

    var locationClient = LocationClient()
    var locationInfo = [String: String]()
    var isEdit = false
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pageTitle: UILabel!
    
    @IBAction func submitButtonTapped(sender: UIButton) {
        self.locationInfo["name"] = self.nameField.text
        self.locationInfo["isEdit"] = String(self.isEdit)
        // if we are editing, the dictionary that was passed in also contains an eventId
        
        locationClient.setDict(diction: locationInfo) {
            self.locationClient.createLocation(){ dict in
                print(self.locationClient.dict)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.locationInfo.isEmpty {
            //if we are editing, populate the fields and indicate this
            self.populateFields()
            self.isEdit = true
            self.submitButton.setTitle("Edit Location",for: .normal)
            self.pageTitle.text = "Edit Location"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateFields() {
        self.nameField.text = self.locationInfo["name"]
    }


}
