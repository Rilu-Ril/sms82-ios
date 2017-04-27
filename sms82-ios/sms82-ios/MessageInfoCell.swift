//
//  MessageInfoCell.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation


class MessageInfoCell: UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblReceivers: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func applyMessageData(_ message: Message) {
        lblTime.text  = DateManager().getTime(from: message.timestamp)
        lblDate.text = DateManager().getDate(from: message.timestamp)
        lblMessage.text = message.body
        lblReceivers.text = "\(message.receivers)"
    }

}

