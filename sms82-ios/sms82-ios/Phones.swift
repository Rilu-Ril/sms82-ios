//
//  Phones.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Phone {
    var number: String
    var status: String
    init(json: JSON) {
        number = json["number"].stringValue
        status = json["status"].stringValue
    }
}

class Phones: NSObject {
    var array: Array = Array<Phone>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Phone(json:json)
            array.append(tempObject)
        }
    }
}
