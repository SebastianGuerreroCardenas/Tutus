//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

// MARK: UISearch extension
extension EventGuestTeamListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class EventGuestTeamListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties & Outlets
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var titleLabel: UINavigationItem!
    var eventGuestRiskListModel = EventGuestRiskListModel()
    var eventClient = EventClient()
    var guestClient = GuestClient()
    var locationClient = LocationClient()
    var assignmentClient = AssignmentClient()
    
    @IBAction func addGuestAction(_ sender: Any) {
        openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "GuestCreation", strStoryboard: "GuestCreation", animationStyle: "fade")
        
        if eventGuestRiskListModel.guests.count < Int(currentEventObject.max_attendance)! {
            openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "GuestCreation", strStoryboard: "GuestCreation", animationStyle: "fade")
        }
        else {
            showAlertWithTitle(title: "Sorry! You can't do that", message: "The creator of this event only alloted " + currentEventObject.max_attendance + ", so you have already run out! Sorry!" )
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEvent = newEvent
        titleLabel.title = "Guest List"
        eventClient.getEventByID() { event in
            currentEventObject = event
            self.eventClient.getEventUsers() { event_users in
                currentEventObject.event_users = event_users
                self.locationClient.fetchRepositories() { locs in
                    globalLocations = locs
                    self.assignmentClient.fetchRepositories() { assignments in
                        globalAssignments = assignments
                        
                    }
                }
            }
        }
        
        let cellNib = UINib(nibName: "RiskTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        addSlideMenuButton()
        setupSearchBar()
        // get the data for the tabler
        eventGuestRiskListModel.refresh { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        eventGuestRiskListModel.refresh { [unowned self] in
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
        return eventGuestRiskListModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RiskTableViewCell
        cell.name?.text = eventGuestRiskListModel.titleForRowAtIndexPath(indexPath)
        cell.birthday?.text = eventGuestRiskListModel.birthdateForRowAtIndexPath(indexPath)
        cell.id = eventGuestRiskListModel.idForRowAtIndexPath(indexPath)
        cell.phone?.text = eventGuestRiskListModel.phoneForRowAtIndexPath(indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //what
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editOption = UITableViewRowAction(style: .normal, title: "Edit") {action,index in
            let Storyboard = UIStoryboard(name: "GuestCreation", bundle: nil)
            let controller = Storyboard.instantiateViewController(withIdentifier: "GuestCreation") as! GuestCreationViewController
            controller.guestInfo = self.eventGuestRiskListModel.guestDictionaryForRowAtIndexPath(index)
            self.present(controller, animated: true, completion: nil)
        }
        
        let checkInOption = UITableViewRowAction(style: .normal, title: "Check In") {action,index in
            let guest: Guest = self.eventGuestRiskListModel.guestModelForRowAtIndexPath(index)
            self.guestClient.checkGuestIntoEvent(checkIn: true, guest: guest) {
                self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
                self.titleLabel.title = "Checked In!"
            }
        }
        
        let checkOutOption = UITableViewRowAction(style: .normal, title: "Check Out") {action,index in
            let guest: Guest = self.eventGuestRiskListModel.guestModelForRowAtIndexPath(index)
            self.guestClient.checkGuestIntoEvent(checkIn: false, guest: guest) {
                self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
                self.titleLabel.title = "Checked Out!"
            }
            
        }
        editOption.backgroundColor = UIColor.blue
        checkInOption.backgroundColor = UIColor.green
        checkOutOption.backgroundColor = UIColor.orange
        return[editOption, checkInOption, checkOutOption]
    }
    
    // MARK: Search Methods
    func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor(red: 0.98, green:0.24, blue:0.36, alpha:1.0)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        eventGuestRiskListModel.updateFiltering(searchText)
        tableView.reloadData()
    }
    
}

