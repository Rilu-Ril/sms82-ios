//
//  DataManager.swift
//  sms82-ios
//
//  Created by Sanira on 4/22/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation

class DataManager {
    class var shared: DataManager {
        struct Static {
            static let instance = DataManager()
        }
        return Static.instance
    }
    
    func setMessagesLeft(_ m: String) {
        UserDefaults.standard.set(m, forKey: "messages_left")
    }
    
    func getMessagesLeft() -> String {
        if let ml = UserDefaults.standard.string(forKey: "messages_left") {
            return ml 
        }
        return ""
    }
    
    
    
    func setMessagesSent(_ m: String) {
        UserDefaults.standard.set(m, forKey: "messages_sent")
    }
    
    func getMessagesSent() -> String{
        if let ms = UserDefaults.standard.value(forKey: "messages_sent") {
            return ms as! String
        }
        return ""
    }
    
    func setPassord(_ pass: String) {
        UserDefaults.standard.set(pass, forKey: "password")
    }
        
    func getPassword() -> String {
        if let a = UserDefaults.standard.string(forKey: "password") {
            return a
        }
        return ""
    }
    
    func setUsername(_ m: String) {
        UserDefaults.standard.set(m, forKey: "username")
    }
    
    func getUsername() -> String {
        
        if let username = UserDefaults.standard.value(forKey: "username") {
            return username as! String
        }
        
        return ""
    }
    
    func getDeviceID() -> String {
        return  UIDevice.current.identifierForVendor!.uuidString
    }
    
}
