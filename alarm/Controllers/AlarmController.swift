//
//  AlarmController.swift
//  alarm
//
//  Created by Ian Hall on 8/5/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation
import UserNotifications


protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}
extension AlarmScheduler{
    func scheduleUserNotifications (for alarm: Alarm) {
        let alarmNote = UNMutableNotificationContent()
        alarmNote.body = "your alarm has gone off"
        alarmNote.title = "\(alarm.name)"
        
        var date = DateComponents()
        date.hour = Calendar.current.component(.hour, from: alarm.fireDate)
        date.minute = Calendar.current.component(.minute, from: alarm.fireDate)
        date.second = 0

        let calendar = UNCalendarNotificationTrigger(dateMatching: date , repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: alarmNote, trigger: calendar)
        print("notification set")
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("notification Failed")
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    func cancelUserNotifications (for alarm: Alarm){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        print("print notification removed")
    }
}

class AlarmController: AlarmScheduler {
    
    static var sharedInstance = AlarmController()
    
    var alarmCollection: [Alarm] = []
    
    //CRUD
    
    //MARK: CREATE
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool){
        let newAlarm = Alarm(name: name, enabled: enabled, fireDate: fireDate)
        alarmCollection.append(newAlarm)
        scheduleUserNotifications(for: newAlarm)
        saveToPersistentStore()
    }
    
    //MARK: update
    
    func updateAlarm(new alarm: Alarm, new fireTime: Date, new name: String, enabled: Bool){
        cancelUserNotifications(for: alarm)
        alarm.fireDate = fireTime
        alarm.name = name
        alarm.isEnabled = enabled
        scheduleUserNotifications(for: alarm)
        
        saveToPersistentStore()
    }
    
    //MARK: Delete
    
    func delete(alarm: Alarm){
        guard let index = alarmCollection.firstIndex(of: alarm) else {return}
        alarmCollection.remove(at: index)
        cancelUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    
    //MARK: OTHER
    
    func toggleEnabled(for alarm: Alarm){
        if alarm.isEnabled{
            alarm.isEnabled = false
            scheduleUserNotifications(for: alarm)
        } else {
            alarm.isEnabled = true
            cancelUserNotifications(for: alarm)
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

