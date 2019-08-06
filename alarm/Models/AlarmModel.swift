//
//  Model.swift
//  alarm
//
//  Created by Ian Hall on 8/5/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable{
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.fireDate == rhs.fireDate && lhs.name == rhs.name && lhs.isEnabled == rhs.isEnabled && lhs.uuid == rhs.uuid && lhs.fireTimeAsString == rhs.fireTimeAsString
    }
    
    var name: String
    var isEnabled: Bool
    var fireDate: Date
    var uuid: String
    var fireTimeAsString: String {
        get{
            return fireDate.description
        }
    }
    init(name: String, enabled: Bool,fireDate: Date) {
        self.name = name
        self.isEnabled = enabled
        self.fireDate = fireDate
        self.uuid = UUID().uuidString
    }
}
