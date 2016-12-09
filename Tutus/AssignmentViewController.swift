//
//  AssignmentViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 12/7/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//
import UIKit

class AssignmentViewController: BaseViewController {
    
    var assignmentsClient = AssignmentClient()
    
    @IBAction func addAssignmentAction(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "AssignmentCreation", bundle: nil)
        let controller = loginStoryboard.instantiateViewController(withIdentifier: "AssignmentCreation") as UIViewController //as! AssignmentCreationViewController
        
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func showAssignments(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "AssignmentGridView", bundle: nil)
        let controller = loginStoryboard.instantiateViewController(withIdentifier: "AssignmentView") as UIViewController  //as! AssignmentGridViewController
//        assignmentsClient.fetchRepositories() { assignments in
//            controller.existingAssignments = assignments
//            self.present(controller, animated: true)
//        }
        
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
