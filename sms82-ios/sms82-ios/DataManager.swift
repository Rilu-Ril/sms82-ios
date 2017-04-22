//
//  DataManager.swift
//  sms82-ios
//
//  Created by Sanira on 4/22/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation

class DataManager {
    class var sharedInstance: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
    
    func setMessagesLeft(_ m: String) {
        UserDefaults.standard.set(m, forKey: "messages_left")
    }
    func getMessagesLeft() -> String {
        return UserDefaults.standard.value(forKey: "messages_left") as! String
    }
    
    func setMessagesSent(_ m: String) {
        UserDefaults.standard.set(m, forKey: "messages_sent")
    }
    func getMessagesSent() -> String{
        return UserDefaults.standard.value(forKey: "messages_sent") as! String
    }
    
    func setUsername(_ m: String) {
        UserDefaults.standard.set(m, forKey: "username")
    }
    func getUsername() -> String {
        return UserDefaults.standard.value(forKey: "username") as! String
    }
    
}
