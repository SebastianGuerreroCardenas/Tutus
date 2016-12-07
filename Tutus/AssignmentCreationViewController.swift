//
//  AssignmentCreationViewController.swift
//  Tutus
//
//  Created by Mark Vella on 12/5/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentCreationViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var locations = ["Location 1", "Location 2", "Location 3", "Location 4", "Location 5"]
    
    var hours: Int = 0
    var startTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date1 = dateFormatter.date(from: "2016-12-05 15:10:00")
        let date2 = dateFormatter.date(from: "2016-12-06 15:10:00")
        hours = Int((date2?.timeIntervalSince(date1!))! / 360)
    
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "HH:mm a"
        startTime = dateFormatter2.string(from:date1!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.hours
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.personLocation.text = locations[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        //display picker
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        //dismiss picker and change text labels to match
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableview: UICollectionReusableView? = nil
        let headerView: CollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as! CollectionReusableView
        headerView.headerLabel.text = "Hour " + String(indexPath.section) + ", Starts at " + startTime
        reusableview = headerView
        return reusableview!
    }
    
    
}
