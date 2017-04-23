//
//  MessageStatusVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit

class MessageStatusVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
         self.title = "Message status"
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        ServerManager.sharedInstance.getMessages(setMessages, error: showErrorAlert)
    }
    
    func setMessages(messages: Messages) {
        self.messages = messages.array
        tableView.reloadData()
    }
    
    @IBAction func showDetails(_ button: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "DetailedMessagesStatusVC") as! DetailedMessagesStatusVC
        vc.messageId = messages[button.tag].id
        self.navigationController?.show(vc, sender: self)
        
    }
}


extension MessageStatusVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "MessageInfoCell", for: indexPath) as! MessageInfoCell
    
        cell.applyMessageData(messages[indexPath.row])
        cell.btnMore.tag = indexPath.row
        cell.btnMore.addTarget(self, action: #selector(showDetails(_:)), for: .touchUpInside)
        return cell
    }
    
    
}
