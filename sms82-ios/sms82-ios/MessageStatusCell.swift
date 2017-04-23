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
    
    func setStatus(phone: Phone) {
        let status = phone.status
        lblStatus.text = status
        if status == "success" {
            lblStatus.textColor = UIColor.green
            activityIndicator.isHidden = true
        } else if status == "error" {
            lblStatus.textColor = UIColor.red
            activityIndicator.isHidden = true
        } else {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            lblStatus.isHidden = true
        }
        
        lblStatus.text = status
        lblNumber.text = phone.number
    }
    
}
