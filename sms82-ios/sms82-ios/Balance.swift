//
//  Balance.swift
//  sms82-ios
//
//  Created by Sanira on 4/22/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import SwiftyJSON

class Balance: BaseModel {
    var allowed_length: Int = 0
    var user_balance: Int = 0

    override init(json: JSON) {
        allowed_length = json["allowed_length"].intValue
        user_balance = json["balance"].intValue
        super.init(json: json)
    }
}
