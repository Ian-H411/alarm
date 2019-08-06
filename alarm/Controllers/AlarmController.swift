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
    
    //CRUD
    
    //MARK: CREATE
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool){
        let newAlarm = Alarm(name: name, enabled: enabled, fireDate: fireDate)
        alarmCollection.append(newAlarm)
        saveToPersistentStore()
    }
    
    //MARK: update
    
    func updateAlarm(new alarm: Alarm, new fireTime: Date, new name: String, enabled: Bool){
        alarm.fireDate = fireTime
        alarm.name = name
        alarm.isEnabled = enabled
        saveToPersistentStore()
    }
    
    //MARK: Delete
    
    func delete(alarm: Alarm){
        guard let index = alarmCollection.firstIndex(of: alarm) else {return}
        alarmCollection.remove(at: index)
        saveToPersistentStore()
    }
    
    
    //MARK: OTHER
    
    func toggleEnabled(for alarm: Alarm){
        if alarm.isEnabled{
            alarm.isEnabled = false
        } else {
            alarm.isEnabled = true
        }
    }
    
    //save functionality
    func fileURL() -> URL {
        // this will get get you a list of URLS in the document directory(where we want to save) under the users domain
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // here were just gonna grab the first one on that list
        let documentDirectory = paths[0]
        //were gonna make a name for it specifying what kind of data it is (JSON)
        let filename = "AlarmData.json"
        //now we name the actual file here
        let fullURL = documentDirectory.appendingPathComponent(filename)
        return fullURL
    }
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(alarmCollection)
            try data.write(to: fileURL())
        } catch let e{
            print(e)
        }
    
    
    }
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let alarms = try decoder.decode([Alarm].self, from: data)
            self.alarmCollection = alarms
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
