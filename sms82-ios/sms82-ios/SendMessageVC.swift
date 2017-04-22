//
//  SendMessageVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit
import IQKeyboardManager
import MapKit


class SendMessageVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate, UITextViewDelegate {
    
    enum SEC_TYPE {
        case textField
        case buttons
    }
    
    @IBAction func addNumber(_ sender: Any) {
        if numbers.count >= userBalance {
            return
        }
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
        let msg = self.textMessage.text!
  
        let messageSendModel = Info(message: msg, phones: numbers, geolocation: [lat,lon])
        
        ServerManager.sharedInstance.sendMessage(message: messageSendModel, { (resp) in
            print(resp)
            self.present()
            print("response: \(resp.notification)")
            
           // UserDefaults.standard.set(resp.balance, forKey: "messagesLeft")
            
        
        }, error: showErrorAlert)
    }
    
    @IBOutlet var scrolView: UIScrollView!
    @IBOutlet weak var textMessage: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    
    var numbers: [String] = ["","","",""]
    var rowHeight = 55
    var lat = ""
    var lon = ""
    var maxLenght = 100
    var userBalance = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        self.title = NSLocalizedString("Send Message", comment: "Send Message")
        tableView.tableFooterView = UIView()
        textMessage.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        ServerManager.sharedInstance.getBalance(completion: { (balance) in
            self.maxLenght = balance.allowed_length
            self.userBalance = balance.user_balance
            print("ballance: \(self.userBalance) - lenght: \(self.maxLenght)")
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
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.characters.count // for Swift use count(newText)
        return numberOfChars < maxLenght
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if lat != "" {
            return
        }
        if let location = manager.location {
            let locValue:CLLocationCoordinate2D = location.coordinate
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.lat = "\(locValue.latitude)"
            self.lon = "\(locValue.longitude)"
        }
    }
    
    func present() {
        let revealVC =  self.revealViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc  = storyboard.instantiateViewController(withIdentifier: "messageStatus")
        revealVC?.pushFrontViewController(vc, animated: false)
    }
}

extension SendMessageVC: UITableViewDataSource {
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
        //let cell: UITableViewCell
        if indexPath.section == SEC_TYPE.textField.hashValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NumbersCell", for: indexPath) as! NumbersCell
            cell.textField.tag = indexPath.row + 1
            cell.textField.delegate = self
            return cell
        }
        let cell =   tableView.dequeueReusableCell(withIdentifier: "actions")!
        
        
        return cell
    }
    
}

extension SendMessageVC: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        IQKeyboardManager.shared().isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(rowHeight)
        
    }
}
