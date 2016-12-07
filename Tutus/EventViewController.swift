//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class EventViewController: BaseViewController {
    @IBOutlet weak var eventNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButton()
        currentEvent = newEvent
        setLabels()
        
    }
    @IBAction func editAssignmentAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "AssignmentCreation", bundle: nil)
        let controller = loginStoryboard.instantiateViewController(withIdentifier: "AssignmentCreation") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLabels() {
        eventNameLabel.text = currentEventObject.title
    }
    
    
}

