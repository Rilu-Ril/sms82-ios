//
//  MessageStatusCell.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation

class MessageStatusCell: UITableViewCell {
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
