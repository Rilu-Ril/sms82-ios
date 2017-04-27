//
//  Login.swift
//  sms82-ios
//
//  Created by Sanira on 4/22/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON

class LoginModel {
    var login: String = ""
    var password: String = ""
    var device_id: String  = ""
    var geolocation: [String] = []
        
    init() {
    }
    
    func toDic() -> [String: Any]{
        var d = [String: Any]()
        d.updateValue(login, forKey: "username")
        d.updateValue(password, forKey: "password")
        d.updateValue("\(geolocation[0]),\(geolocation[1])", forKey: "geolocation")
        d.updateValue(device_id, forKey: "user_device_id")
        return d
    }
}

class LoginResponse: BaseModel {
    var info: String = "" //fail success
    var status: String = ""

     override init(json: JSON) {
        info = json["info"].stringValue
        status = json["status"].stringValue
        super.init(json: json)
    }
    
}
