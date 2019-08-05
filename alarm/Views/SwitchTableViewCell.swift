//
//  SwitchTableViewCell.swift
//  alarm
//
//  Created by Ian Hall on 8/5/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func cellSwitchValueChanged(cell: SwitchTableViewCell)
    
}


class SwitchTableViewCell: UITableViewCell {
    //MARK: outlets
   
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm?{
        didSet{
            updateViews()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews(){
        if let alarm = alarm {
            let formater = DateFormatter()
            formater.timeStyle = .short
            nameLabel.text = alarm.name
            timeLabel.text = formater.string(from: alarm.fireDate)
            alarmSwitch.isOn = alarm.isEnabled
        } else {
            nameLabel.text = ""
            timeLabel.text = ""
            alarmSwitch.isOn = false
    }
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.cellSwitchValueChanged(cell: self)
}
}
