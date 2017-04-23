//
//  DetailedMessagesStatusVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit

class DetailedMessagesStatusVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var phones: [Phone] = []
    var messageId = 0
    var requestCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = "Message details"
        requestMessageDetails()
    }
    
    func requestMessageDetails() {
        
        requestCount += 1
        
        let _ = Timer.scheduledTimer(timeInterval: 5, target: self,
                    selector: #selector(self.requestMessageDetails),
                    userInfo: nil, repeats: true)
        
        if requestCount < 5 {
            ServerManager.sharedInstance.getMessageDelails(
                by: messageId, completion: { (msgStatus) in
                self.phones = msgStatus.phones.array
                self.tableView.reloadData()
            }, error: showErrorAlert)
        }
       
    }
}

extension DetailedMessagesStatusVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return phones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell: UITableViewCell
            cell = tableView.dequeueReusableCell(withIdentifier: "InfoStatus")!
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageStatusCell",
                                                 for: indexPath) as! MessageStatusCell
        cell.setStatus(phone: phones[indexPath.row])
        return cell
    }
}
