//
//  Infos.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Info {
    var message_body: String
    var phones: [String] = []
    var geolocation : [String] = []
    
    init(json: JSON) {
        message_body = json["message_body"].stringValue
        for i in json["phones"].arrayValue{
            phones.append(i.stringValue)
        }
    }
    init(message: String, phones: [String], geolocation: [String]) {
        self.geolocation = geolocation
        self.message_body = message
        self.phones = phones
    }
    func toDict() -> [String: Any]{
        var d = [String: Any]()
        d.updateValue("\(geolocation[0]),\(geolocation[1])", forKey: "geolocation")
        
        d.updateValue(self.message_body, forKey: "message")
        d.updateValue(DataManager.shared.getDeviceID(), forKey: "user_device_id")
        d.updateValue(DataManager.shared.getUsername(), forKey: "username")
        d.updateValue(DataManager.shared.getPassword(), forKey: "password")
        var phoneValue = "["
        for (ind, phone) in phones.enumerated() {
            if phone != "" {
                if ind == 0 {
                    phoneValue += "\"\(phone)\""
                } else{
                    phoneValue += ",\"\(phone)\""
                }
            }
        }
        
        phoneValue += "]"
        
        d.updateValue(phoneValue, forKey: "phones")
        
        return d
    }
}

class Infos: NSObject {
    var array: Array = Array<Info>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Info(json:json)
            array.append(tempObject)
        }
    }
}
