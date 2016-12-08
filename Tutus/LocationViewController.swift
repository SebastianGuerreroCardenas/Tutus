//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class LocationViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties & Outlets
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var locationListModel = LocationListModel()
    var eventClient = EventClient()
    var locationClient = LocationClient()
    
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
        locationListModel.refresh { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationListModel.refresh { [unowned self] in
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
        return locationListModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
        cell.locationLabel?.text = locationListModel.titleForRowAtIndexPath(indexPath)
        cell.descriptionLabel?.text = locationListModel.descriptionForRowAtIndexPath(indexPath)
        cell.id = locationListModel.idForRowAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "toDetailVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //what
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editOption = UITableViewRowAction(style: .normal, title: "Edit") {action,index in
            let location: Location = self.locationListModel.locationtModelForRowAtIndexPath(index)
//            self.locationClient.deleteLocation(id: location.id){
//                self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
//            }
        }

        let deleteOption = UITableViewRowAction(style: .normal, title: "Delete") {action,index in
            let location: Location = self.locationListModel.locationtModelForRowAtIndexPath(index)
            self.locationClient.deleteLocation(id: location.id){
                //self.tableView.deleteRows(at: <#T##[IndexPath]#>, with: <#T##UITableViewRowAnimation#>)
                //self.tableView.deselectRow(at: [index], animated: true)
                self.tableView.deleteRows(at: [index], with: UITableViewRowAnimation.right)
                //self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
            }

        }
        editOption.backgroundColor = UIColor.blue
        deleteOption.backgroundColor = UIColor.red
        return[editOption, deleteOption]
        }
}

