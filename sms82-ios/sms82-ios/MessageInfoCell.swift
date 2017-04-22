//
//  MessageInfoCell.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation


class MessageInfoCell: UITableViewCell {
    
    @IBOutlet weak var lblTimestamp: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var lblReceivers: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
