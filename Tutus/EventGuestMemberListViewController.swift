//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

// MARK: UISearch extension
extension EventGuestMemberListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class EventGuestMemberListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties & Outlets
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var eventGuestMemberListModel = EventGuestMemberListModel()
    var eventClient = EventClient()
    var guestClient = GuestClient()
    
    @IBAction func addGuestAction(_ sender: Any) {

        if eventGuestMemberListModel.guests.count < Int(currentEventObject.max_attendance)! {
            openViewControllerOnIdentifierOnStoryBoard(strIdentifier: "GuestCreation", strStoryboard: "GuestCreation", animationStyle: "fade")
        }
        else {
            showAlertWithTitle(title: "Sorry! You can't do that", message: "The creator of this event only alloted " + currentEventObject.max_attendance + ", so you have already run out! Sorry!" )
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEvent = newEvent
        eventClient.getEventByID() { event in
            currentEventObject = event
        }
        
        let cellNib = UINib(nibName: "RiskTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        addSlideMenuButton()
        setupSearchBar()
        // get the data for the tabler
        eventGuestMemberListModel.refresh { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        eventGuestMemberListModel.refresh { [unowned self] in
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
        return eventGuestMemberListModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RiskTableViewCell
        cell.name?.text = eventGuestMemberListModel.titleForRowAtIndexPath(indexPath)
        cell.birthday?.text = eventGuestMemberListModel.birthdateForRowAtIndexPath(indexPath)
        cell.id = eventGuestMemberListModel.idForRowAtIndexPath(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //what
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let checkInOption = UITableViewRowAction(style: .normal, title: "Check In") {action,index in
//            let guest: Guest = self.eventGuestRiskListModel.guestModelForRowAtIndexPath(index)
//            self.guestClient.checkGuestIntoEvent(checkIn: true, guest: guest) {
//                self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
//            }
//        }
//        
//        let checkOutOption = UITableViewRowAction(style: .normal, title: "Check Out") {action,index in
//            let guest: Guest = self.eventGuestRiskListModel.guestModelForRowAtIndexPath(index)
//            self.guestClient.checkGuestIntoEvent(checkIn: false, guest: guest) {
//                self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
//            }
//            
//        }
//        checkInOption.backgroundColor = UIColor.green
//        checkOutOption.backgroundColor = UIColor.red
//        return[checkInOption, checkOutOption]
//    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? GuestDetailViewController,
            let indexPath = sender as? IndexPath {
            detailVC.guestDetailViewModel = eventGuestMemberListModel.detailViewModelForRowAtIndexPath(indexPath)
        }
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
        eventGuestMemberListModel.updateFiltering(searchText)
        tableView.reloadData()
    }
    
}

