//
//  AuthentigicationVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit

class AuthentigicationVC: UIViewController {

    @IBAction func Login(_ sender: Any) {
        
    }
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
}
