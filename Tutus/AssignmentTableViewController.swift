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
    
    @IBAction func addLocationAction(_ sender: Any) {
        openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "LocationCreation", strStoryboard: "LocationCreation", animationStyle: "fade")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEvent = newEvent
        eventClient.getEventByID() { event in
            currentEventObject = event
        }
        
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
        //performSegue(withIdentifier: "toDetailVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editOption = UITableViewRowAction(style: .normal, title: "Edit") {action,index in
            let Storyboard = UIStoryboard(name: "LocationCreation", bundle: nil)
            let controller = Storyboard.instantiateViewController(withIdentifier: "LocationCreation") as! LocationCreationViewController
//            controller.locationInfo = self.assignmentListModel.assignmentsDictionaryForRowAtIndexPath(index)
            self.present(controller, animated: true, completion: nil)
        }
        let deleteOption = UITableViewRowAction(style: .normal, title: "Delete") {action,index in
            let assignment: Assignment = self.assignmentListModel.assignmentModelForRowAtIndexPath(index)
            self.assignmentClient.deleteAssignment(id: assignment.id){
                self.assignmentListModel.assignments.remove(at: index.row)
                self.tableView.reloadData()
            }
            
        }
        editOption.backgroundColor = UIColor.blue
        deleteOption.backgroundColor = UIColor.red
        return[editOption, deleteOption]
    }
}

