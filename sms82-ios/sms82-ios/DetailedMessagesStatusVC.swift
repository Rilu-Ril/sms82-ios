//
//  DetailedMessagesStatusVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit

class DetailedMessagesStatusVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var messageId = 0
    var message = ""
    var phones: [Phone] = []
    var requestCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
       requestMessageDetails()
    }
    
    func requestMessageDetails() {
        
        requestCount += 1
        
        let _ = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.requestMessageDetails), userInfo: nil, repeats: true)
        
        if requestCount < 10 {
            print("send: \(requestCount)")
            ServerManager.sharedInstance.getMessageDelails(by: messageId, completion: { (msgStatus) in
                print(msgStatus)
                self.message = msgStatus.message
                self.phones = msgStatus.phones.array
                self.tableView.reloadData()
            }, error: showErrorAlert)
        }
       
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageStatusCell", for: indexPath) as! MessageStatusCell
        
        let status = phones[indexPath.row].status
        cell.lblStatus.text = status
        if status == "success" {
            cell.lblStatus.textColor = UIColor.green
            cell.activityIndicator.isHidden = true
        } else if status == "error" {
            cell.lblStatus.textColor = UIColor.red
            cell.activityIndicator.isHidden = true
        } else {
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
            cell.lblStatus.isHidden = true
        }
        
            cell.lblStatus.text = status
            cell.lblNumber.text = phones[indexPath.row].number
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
