//
//  SendMessageVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MapKit


class SendMessageVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    enum SEC_TYPE {
        case textField
        case buttons
    }
    
    @IBOutlet var scrolView: UIScrollView!
    @IBOutlet weak var textMessage: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    
    var numbers: [String] = ["","","",""]
    
    var rowHeight = 55
    var lat = "0"
    var lon = "0"
    var maxLenght = 100
    var userBalance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        self.title = "Send message"
        
        tableView.tableFooterView = UIView()
        textMessage.delegate = self
        
        setLocationManager()
        loadBalance()
        
   
    }
    
    func setLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func loadBalance() {
        ServerManager.sharedInstance.getBalance(completion: { (balance) in
            self.maxLenght = balance.allowed_length
            self.userBalance = balance.user_balance
        }, error: showErrorAlert)
    }
    
    @IBAction func addNumber(_ sender: Any) {
        
        var numberCount = 0
        for n in numbers {
            if n != "" {
                numberCount += 1
            }
        }
        
        if numberCount >= userBalance {
            showErrorAlert(message: "Exсeed balance")
            return
        }
        
        numbers.append("")
        tableView.reloadData()
        updateScrollView()
    }
    
    func updateScrollView() {
        updateViewConstraints()
        let y =  scrolView.contentOffset.y
        let x = scrolView.contentOffset.x
        
        let height = textMessage.frame.size.height + 36 + tableViewHeight.constant
        if height > UIScreen.main.bounds.height - 2 {
            scrolView.setContentOffset(CGPoint(x: x,
                                               y: y + CGFloat(rowHeight)),
                                       animated: true)
        }
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let msg = self.textMessage.text!
        let messageSendModel = Info(message: msg,
                                    phones: numbers,
                                    geolocation: [lat,lon])
        
        ServerManager.sharedInstance.sendMessage(message:
            messageSendModel, { (resp) in
            self.presentStatusVC()
        }, error: showErrorAlert)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let height = (numbers.count + 1) * rowHeight
        tableViewHeight.constant = CGFloat(height)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            return
        }
        self.numbers[textField.tag - 1] = textField.text!
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn
        range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString)
            .replacingCharacters(in: range, with: text)
        
        let numberOfChars = newText.characters.count
        return numberOfChars < maxLenght
    }
    
    
    func presentStatusVC() {
        let revealVC =  self.revealViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(
            withIdentifier: "messageStatus")
        revealVC?.pushFrontViewController(vc, animated: false)
    }

}

extension SendMessageVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == SEC_TYPE.textField.hashValue {
            return numbers.count
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SEC_TYPE.textField.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumbersCell",
                                                     for: indexPath) as! NumbersCell
            cell.textField.tag = indexPath.row + 1
            cell.textField.delegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "actions")!
        return cell
    }
    
}

extension SendMessageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(rowHeight)
    }
}

extension SendMessageVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if let location = manager.location {
            let locValue:CLLocationCoordinate2D = location.coordinate
            self.lat = "\(locValue.latitude)"
            self.lon = "\(locValue.longitude)"
            manager.stopUpdatingLocation()
        }
    }
}
