//
//  RiskTableViewCell.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 12/3/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class RiskTableViewCell: UITableViewCell {
    var id: String = ""
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var birthday: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    @IBAction func inOutAction(_ sender: Any) {
        print(segmentedControl.selectedSegmentIndex)
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            print("0" + id)
//        case 1:
//            print("1" + id)
//        default:
//            break
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
