//
//  AssignmentTableViewCell.swift
//  Tutus
//
//  Created by Sebastian Guerrero on 12/8/16.
//  Copyright © 2016 Sebastian Guerrero. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var locationDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
