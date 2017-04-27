//
//  BaseModel.swift
//  sms82-ios
//
//  Created by Sanira on 4/22/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseModel: NSObject {
    var messageSent: String
    var messageLeft: String
    init(json: JSON) {
        
        self.messageSent = json["messages_sent"].stringValue
        self.messageLeft = json["messages_left"].stringValue
        
        super.init()
        
        if self.messageSent != "" {
            DataManager.shared.setMessagesSent(self.messageSent)
        }
        
        if self.messageLeft != "" {
            DataManager.shared.setMessagesLeft(self.messageLeft)
        }
    }
   
}
