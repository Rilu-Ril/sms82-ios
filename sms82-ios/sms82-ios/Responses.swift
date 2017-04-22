//
//  Responses.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON


class Response: BaseModel {
    var previous_balance: Int
    var balance: Int
    var notification: String
    
    override init(json: JSON) {
        //super.init(json: json)
        previous_balance = json["previous_balance"].intValue
        balance = json["balance"].intValue
        notification = json["notification"].stringValue
        super.init(json: json)
        
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
