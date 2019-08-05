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
    
    var alarmLanding: Alarm?{
        didSet{updateViews()}
    }
    
    var alarmIsOn: Bool =  true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let alarmUnwrapped = alarmLanding {
            alarmIsOn = alarmUnwrapped.isEnabled}
        updateViews()
        
        
    }
    
    // MARK: - Table view data source
     func updateViews(){
        loadViewIfNeeded()
        if let alarm = alarmLanding {
            timePicker.date = alarm.fireDate
            titleText.text = alarm.name
            if alarm.isEnabled{
                enableDisableButton.backgroundColor = .red
                enableDisableButton.setTitle("disable", for: .normal)
                alarmIsOn = true
            } else {
                enableDisableButton.backgroundColor = .green
                enableDisableButton.setTitle("Enable", for: .normal)
                alarmIsOn = false
            }
            
        } else {
            timePicker.date = Date()
            titleText.text = ""
            enableDisableButton.backgroundColor = .green
            enableDisableButton.setTitle("Enable", for: .normal)
        }
        tableView.reloadData()
    }
    //MARK: - Actions
    
    @IBAction func enableDisableButtonTapped(_ sender: UIButton) {
            if alarmIsOn{
                alarmIsOn = false
                enableDisableButton.backgroundColor = .green
                enableDisableButton.setTitle("Enable", for: .normal)
    
            } else{
                alarmIsOn = true
                enableDisableButton.backgroundColor = .red
                enableDisableButton.setTitle("disable", for: .normal)
        }
    
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        if titleText.text! == "" {return}
        if let alarm = alarmLanding{
            AlarmController.sharedInstance.updateAlarm(new: alarm, new: timePicker.date, new: titleText.text!, enabled: alarmIsOn)
            
        } else{
            AlarmController.sharedInstance.addAlarm(fireDate: timePicker.date, name: titleText.text!, enabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
