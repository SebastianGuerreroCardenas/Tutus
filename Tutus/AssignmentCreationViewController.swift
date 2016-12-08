//
//  AssignmentCreationViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentCreationViewController: UICollectionViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var locations:[String] = []
    var people:[User] = []
    var hours: Int = 0
    var startTime: String = "not loaded"
    var endTime: String = "not loaded"
    var chosenPeople:[[Assignment]] = [[]] //user object for picker and location ID for creating assignment object
    let assignmentsClient = AssignmentClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let placeholder = Assignment(id: "1", location_id: "1", user_id: "1", start: "1", end: "1")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date1 = dateFormatter.date(from: currentEventObject.start)
        let date2 = dateFormatter.date(from: currentEventObject.end)
        print(currentEventObject.start)
        print(currentEventObject.end)
        self.hours = Int(((date2?.timeIntervalSince(date1!))! / 60) / 60)
    
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm a"
        self.startTime = dateFormatter2.string(from:date1!)
        self.endTime = dateFormatter2.string(from:date2!)

        self.assignmentsClient.getLocationsByID(){ locations in
            for loc in self.assignmentsClient.locations {
                self.locations.append(loc.name)
            }
        }
        self.locations = ["Location 1", "Location 2", "Location 3", "Location 4", "Location 5"]
        
        for u in currentEventObject.event_users {
            self.people.append(u)
        }
        self.chosenPeople = []
        for i in 1...self.locations.count {
            var secList = [Assignment]()
            for j in 1...self.hours {
                secList.append(placeholder)
            }
            self.chosenPeople.append(secList)
        }
        self.people = [mainUser.userObject, mainUser.userObject, mainUser.userObject, mainUser.userObject, mainUser.userObject]
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        var assignmentsInfo = [String: [String: String]]()
        for section in 0...self.chosenPeople.count {
            for person in 0...self.chosenPeople[section].count {
//                let startT = (self.startTime[0 .. 11] + String(Int(self.startTime.[11 .. 13]) + section) + self.startTime.[13 ..< 19])
//                let endT = (String(self.startTime.characters[0..10]) + String(Int(String(self.startTime.characters[11..12])) + section + 1) + String(self.startTime.characters[13..18]))
                assignmentsInfo[self.chosenPeople[section][person].user_id + self.chosenPeople[section][person].location_id] = ["event_id": String(currentEventObject.id), "location_id": self.chosenPeople[section][person].location_id, "user_id": self.chosenPeople[section][person].user_id, "start": self.startTime, "end": self.endTime, "attended": "false"]
            }
        }
        print(assignmentsInfo)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
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
        self.chosenPeople[Int(pickerView.restorationIdentifier!)!][Int(pickerView.accessibilityHint!)!] = Assignment(id: "", location_id: String(row), user_id: people[row].id, start: "", end: "")
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
        locationLabel.text = self.locations[indexPath.row]
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
