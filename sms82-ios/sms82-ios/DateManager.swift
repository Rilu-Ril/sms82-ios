//
//  DateManager.swift
//  sms82-ios
//
//  Created by Sanira on 4/23/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation

class DateManager {
    init() {
        
    }
    func getDate(from timestamp: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        guard let date = dateFormatter.date(from: timestamp) else {
            assert(false, "no date from string")
            return ""
        }
        
        
        dateFormatter.dateFormat = "EEEE, MMM, yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let d = dateFormatter.string(from: date)
        return d
    }
    
    func getTime(from timestamp: String) -> String  {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        guard let date = dateFormatter.date(from: timestamp) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let time = dateFormatter.string(from: date)
        return time
    }
   
    
}
