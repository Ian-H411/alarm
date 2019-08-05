//
//  SwitchTableViewCell.swift
//  alarm
//
//  Created by Ian Hall on 8/5/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    //MARK: outlets
    @IBOutlet weak var timeLabel: UIStackView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
    }
}
