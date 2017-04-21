//
//  Messages.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Message {
    var id: Int
    var sender: String
    var receivers: Int
    var body: String
    var timestamp: String
    
    init(json: JSON) {
        id = json["id"].intValue
        sender = json["sender"].stringValue
        receivers = json["receivers"].intValue
        body = json["body"].stringValue
        timestamp = json["timestamp"].stringValue
    }
}

class Messages: NSObject {
    var array: Array = Array<Message>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Message(json:json)
            array.append(tempObject)
        }
    }
}
