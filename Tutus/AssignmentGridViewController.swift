//
//  AssignmentCreationViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentGridViewController: UICollectionViewController {
    
    var locations:[Location] = []
    var people:[User] = []
    var hours: Int = 0
    var startTime: String = "not loaded"
    var endTime: String = "not loaded"
    var existingAssignments:[Assignment] = []
    let assignmentsClient = AssignmentClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date1 = dateFormatter.date(from: currentEventObject.start)
        let date2 = dateFormatter.date(from: currentEventObject.end)
        self.hours = Int(((date2?.timeIntervalSince(date1!))! / 60) / 60)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm a"
        self.startTime = dateFormatter2.string(from:date1!)
        self.endTime = dateFormatter2.string(from:date2!)
        
        self.locations = globalLocations
        
        for u in currentEventObject.event_users {
            self.people.append(u)
        }
        self.people = currentEventObject.event_users
        
        self.assignmentsClient.createAssignment() { dict in
            print(dict)
            //self.existingAssignments = dict
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Event", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EventMain") as UIViewController
        present(controller, animated: true)
        print("CANCEL!!!")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.hours
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.existingAssignments.count / self.hours
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as UICollectionViewCell
        let locationLabel = cell.viewWithTag(2) as! UILabel
        locationLabel.text = self.locations[indexPath.row].name
        let personLabel = cell.viewWithTag(3) as! UILabel
        personLabel.text = "This is a person" //put the data here
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionReusableView", for: indexPath) as UICollectionReusableView
        let headerLabel = headerView.viewWithTag(1) as! UILabel
        headerLabel.text = "Hour " + String(indexPath.section + 1) + ", started at " + self.startTime
        return headerView
    }
    
    
}
