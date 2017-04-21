//
//  Responses.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Response {
    var previous_balance: Int
    var balance: Int
    var notification: String
    init(json: JSON) {
        previous_balance = json["previous_balance"].intValue
        balance = json["balance"].intValue
        notification = json["notification"].stringValue
    }
}

class Responses: NSObject {
    var array: Array = Array<Response>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Response(json:json)
            array.append(tempObject)
        }
    }
}
