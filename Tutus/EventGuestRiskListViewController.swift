//
//  ViewController.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 11/21/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

// MARK: UISearch extension
extension EventGuestRiskListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class EventGuestRiskListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var eventGuestRiskListModel = EventGuestRiskListModel()
    var eventClient = EventClient()
    var guestClient = GuestClient()
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //what
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var checkInOption = UITableViewRowAction(style: .normal, title: "Check In") {action,index in
            print("hello");
            print(index.row);
            let guest: Guest = self.eventGuestRiskListModel.guestModelForRowAtIndexPath(index)
            self.guestClient.checkGuestIntoEvent(checkIn: true, guest: guest) {
                self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
            }
        }
        
        var checkOutOption = UITableViewRowAction(style: .normal, title: "Check Out") {action,index in
            print("hello");
            print(index.row);
            let guest: Guest = self.eventGuestRiskListModel.guestModelForRowAtIndexPath(index)
            self.guestClient.checkGuestIntoEvent(checkIn: false, guest: guest) {
                self.tableView.reloadRows(at: [index], with: UITableViewRowAnimation.right)
            }
            
        }
        checkInOption.backgroundColor = UIColor.green
        checkOutOption.backgroundColor = UIColor.red
        return[checkInOption, checkOutOption]
    }
    
    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? GuestDetailViewController,
            let indexPath = sender as? IndexPath {
            detailVC.guestDetailViewModel = eventGuestRiskListModel.detailViewModelForRowAtIndexPath(indexPath)
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
        eventGuestRiskListModel.updateFiltering(searchText)
        tableView.reloadData()
    }
    
}

