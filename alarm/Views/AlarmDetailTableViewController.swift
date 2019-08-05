//
//  AlarmDetailTableViewController.swift
//  alarm
//
//  Created by Ian Hall on 8/5/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    //MARK: - properties
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var enableDisableButton: UIButton!
    
    var alarm: Alarm?{
        didSet{updateViews()}
    }
    
    var alarmIsOn: Bool =  true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarmUnwrapped = alarm {
            alarmIsOn = alarmUnwrapped.isEnabled}
        updateViews()
        
        
    }
    
    // MARK: - Table view data source
    private func updateViews(){
        if let alarm = alarm {
            timePicker.date = alarm.fireDate
            titleText.text = alarm.name
            if alarm.isEnabled{
                enableDisableButton.backgroundColor = .red
                enableDisableButton.setTitle("disable", for: .normal)
            } else {
                enableDisableButton.backgroundColor = .green
                enableDisableButton.setTitle("Enable", for: .normal)
            }
            
        } else {
            timePicker.date = Date()
            titleText.text = ""
            enableDisableButton.backgroundColor = .green
            enableDisableButton.setTitle("Enable", for: .normal)
        }
    }
    //MARK: - Actions
    
    @IBAction func enableDisableButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    
}
