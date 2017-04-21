//
//  MessagesStatus.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MessageStatus {
    var owner: String
    var message: String
    var phones: Phones
    init(json: JSON) {
        owner = json["owner"].stringValue
        message = json["message"].stringValue
        phones = Phones(json: json["phones"])
    }
}

class MessagesStatus: NSObject {
    var array: Array = Array<MessageStatus>()
    init(json:JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = MessageStatus(json:json)
            array.append(tempObject)
        }
    }
}
