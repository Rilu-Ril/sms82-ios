//
//  SideBar.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit

class SideBarVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblMessageLeft: UILabel!
    @IBOutlet weak var lblMessageSent: UILabel!
    
    var names = ["Send Message", "Send message via file", "Message status", "Profile"]
    let navIdentifiers = ["sendMessage", "sendViaFile", "messageStatus" , "profile"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.lblUsername.text = DataManager.sharedInstance.getUsername()
        self.lblMessageLeft.text = DataManager.sharedInstance.getMessagesLeft()
        self.lblMessageSent.text = DataManager.sharedInstance.getMessagesSent()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = names[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 54/255, green: 71/255, blue: 79/255, alpha: 1)
        cell.textLabel?.textColor = UIColor(red: 111/255, green: 133/255, blue: 147/255, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealVC = self.revealViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: navIdentifiers[indexPath.row])
        revealVC?.pushFrontViewController(vc, animated: true)
    }
}

