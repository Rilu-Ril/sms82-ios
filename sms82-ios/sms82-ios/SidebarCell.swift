//
//  SidebarCell.swift
//  sms82-ios
//
//  Created by Sanira on 4/23/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit

class SidebarCell: UITableViewCell {
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
         super.awakeFromNib()
    }
    
    
    func setData(title: String, image: String) {
        self.lbltitle.text = title
        self.imgIcon.image = UIImage(named: image)
    }

    
}
