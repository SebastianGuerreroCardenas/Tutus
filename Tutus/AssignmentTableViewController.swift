//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentTableViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties & Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var assignmentListModel = AsssignmentListModel()
    var eventClient = EventClient()
    var assignmentClient = AssignmentClient()
    
    
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
    
    @IBAction func addLocationAction(_ sender: Any) {
        openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "LocationCreation", strStoryboard: "LocationCreation", animationStyle: "fade")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEvent = newEvent
        
        let cellNib = UINib(nibName: "LocationTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "locationCell")
        addSlideMenuButton()
        // get the data for the tabler
        assignmentListModel.refresh { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        assignmentListModel.refresh { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignmentListModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        cell.locationLabel?.text = assignmentListModel.titleForRowAtIndexPath(indexPath)
        //cell.descriptionLabel?.text = assignmentListModel.descriptionForRowAtIndexPath(indexPath)
        cell.id = assignmentListModel.idForRowAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    

}

