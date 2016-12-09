//
//  AssignmentCreationViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentCreationViewController: UICollectionViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var locations:[Location] = []
    var people:[User] = []
    var hours: Int = 0
    var startTime: String = "not loaded"
    var endTime: String = "not loaded"
    var newAssignments:[Assignment] = []
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
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        var assignmentsInfo = [String: [String: String]]()
        for a in self.newAssignments {
//                let startT = (self.startTime[0 .. 11] + String(Int(self.startTime.[11 .. 13]) + section) + self.startTime.[13 ..< 19])
//                let endT = (String(self.startTime.characters[0..10]) + String(Int(String(self.startTime.characters[11..12])) + section + 1) + String(self.startTime.characters[13..18]))
                assignmentsInfo[a.location_id+a.user_id] = ["event_id": String(currentEventObject.id), "location_id": a.location_id, "user_id": a.user_id, "start": self.startTime, "end": self.endTime, "attended": "false"]
            
        }
        for assign in assignmentsInfo.keys {
            self.assignmentsClient.setDict(diction: assignmentsInfo[assign]!) {
                self.assignmentsClient.createAssignment() { dict in
                    print(dict)
                    let storyboard = UIStoryboard(name: "Event", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "EventMain") as UIViewController
                    self.present(controller, animated: true)
                }
            }
        }
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Event", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EventMain") as UIViewController
        present(controller, animated: true)
        print("CANCEL!!!")
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //we only want one column of data, just the person
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.people.count //we want as many rows as there are people in the array
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row].full_name //put in the person's name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.newAssignments.append(Assignment(id: "", location_id: self.locations[Int(pickerView.accessibilityHint!)!].id, user_id: people[row].id, start: "", end: ""))
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.hours
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as UICollectionViewCell
        let locationLabel = cell.viewWithTag(2) as! UILabel
        locationLabel.text = self.locations[indexPath.row].name
        let picker = cell.viewWithTag(4) as! UIPickerView
        picker.delegate = self
        picker.dataSource = self
        picker.restorationIdentifier = String(indexPath.section)
        picker.accessibilityHint = String(indexPath.row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionReusableView", for: indexPath) as UICollectionReusableView
        let headerLabel = headerView.viewWithTag(1) as! UILabel
        headerLabel.text = "Hour " + String(indexPath.section + 1) + ", started at " + self.startTime
        return headerView
    }
    
    
}
