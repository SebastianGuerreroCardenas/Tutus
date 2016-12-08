//
//  AssignmentCreationViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentCreationViewController: UICollectionViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        
    }
    
    var locations:[String] = []
    var people:[String] = []
    var hours: Int = 0
    var startTime: String = "not loaded"
    var chosenPeople:[[String]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date1 = dateFormatter.date(from: "2016-12-08 20:00:00")
        let date2 = dateFormatter.date(from: "2016-12-08 23:10:00")
        self.hours = Int(((date2?.timeIntervalSince(date1!))! / 60) / 60)
    
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm a"
        self.startTime = dateFormatter2.string(from:date1!)
        self.locations = ["Location 1", "Location 2", "Location 3", "Location 4", "Location 5"]
        self.people = ["Mark", "Sebastian", "Prof H.", "Charles", "Dad"]
        self.people.insert("Please Select", at: 0)
        self.chosenPeople = Array(repeating: Array(repeating: "", count:self.locations.count), count:self.hours)
        
        for h in 1...self.hours {
            for l in 1...self.locations.count {
                self.chosenPeople[h-1][l-1] = ""
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //we only want one column of data, just the person
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.people.count //we want as many rows as there are people in the array
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row] //put in the person's name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.chosenPeople[Int(pickerView.restorationIdentifier!)!][Int(pickerView.accessibilityHint!)!] = people[row]
        print(self.chosenPeople)
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
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as UICollectionViewCell
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as UICollectionViewCell
//    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionReusableView", for: indexPath) as UICollectionReusableView
        let headerLabel = headerView.viewWithTag(1) as! UILabel
        headerLabel.text = "Hour " + String(indexPath.section + 1) + ", started at " + self.startTime
        return headerView
    }
    
    
}
