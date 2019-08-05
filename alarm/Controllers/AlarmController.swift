//
//  AlarmController.swift
//  alarm
//
//  Created by Ian Hall on 8/5/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

class AlarmController {
    
    static var sharedInstance = AlarmController()
    
    var alarmCollection: [Alarm] = []
    
//    var alarmCollection: [Alarm] = [Alarm(name: "wake up", enabled: true, fireDate: Date()), Alarm(name: "dosomethingproductiveyalazy", enabled: false, fireDate: Date()),Alarm(name: "go to sleep", enabled: true, fireDate: Date()) ]
//    
    //CRUD
    
    //MARK: CREATE
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool){
        let newAlarm = Alarm(name: name, enabled: enabled, fireDate: fireDate)
        alarmCollection.append(newAlarm)
    }
    
    //MARK: update
    
    func updateAlarm(new alarm: Alarm, new fireTime: Date, new name: String, enabled: Bool){
        alarm.fireDate = fireTime
        alarm.name = name
        alarm.isEnabled = enabled
    }
    
    //MARK: Delete
    
    func delete(alarm: Alarm){
        guard let index = alarmCollection.firstIndex(of: alarm) else {return}
        alarmCollection.remove(at: index)
    }
    
    
    //MARK: OTHER
    
    func toggleEnabled(for alarm: Alarm){
        if alarm.isEnabled{
            alarm.isEnabled = false
        } else {
            alarm.isEnabled = true
        }
    }

}
