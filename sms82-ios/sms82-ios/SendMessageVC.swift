//
//  SendMessageVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit
import IQKeyboardManager

class SendMessageVC: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    enum SEC_TYPE {
        case textField
        case buttons
    }
    
    @IBAction func addNumber(_ sender: Any) {
        numbers.append("")
        tableView.reloadData()
        updateViewConstraints()
        let y =  scrolView.contentOffset.y
        let x = scrolView.contentOffset.x
        
        let height = textMessage.frame.size.height + 36 + tableViewHeight.constant
        if height > UIScreen.main.bounds.height - 2{
            scrolView.setContentOffset(CGPoint(x: x, y: y + CGFloat(rowHeight)), animated: true)
        }
    }
    @IBAction func sendMessage(_ sender: Any) {
    }
    
    @IBOutlet var scrolView: UIScrollView!
    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var numbers: [String] = ["","","",""]
    var rowHeight = 55
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.title = NSLocalizedString("Send Message", comment: "Send Message")
        tableView.tableFooterView = UIView()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let height = (numbers.count + 1) * rowHeight
        tableViewHeight.constant = CGFloat(height)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SEC_TYPE.textField.hashValue {
            return numbers.count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if indexPath.section == SEC_TYPE.textField.hashValue {
             cell = tableView.dequeueReusableCell(withIdentifier: "NumbersCell", for: indexPath) as! NumbersCell
        } else {
             cell =   tableView.dequeueReusableCell(withIdentifier: "actions")!
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IQKeyboardManager.shared().isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return CGFloat(rowHeight)

    }

}
