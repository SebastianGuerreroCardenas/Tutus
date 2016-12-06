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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
