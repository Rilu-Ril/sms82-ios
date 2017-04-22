//
//  AuthentigicationVC.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import UIKit
import MapKit

class AuthentigicationVC: UIViewController, CLLocationManagerDelegate {

    @IBAction func Login(_ sender: Any) {
        
        var log = LoginModel()
        log.login = self.txtUsername.text!
        log.password = self.txtPassword.text!
        let device_id = UserDefaults.standard.string(forKey: "devid")
        log.device_id = device_id!
        log.geolocation.append(lat)
        log.geolocation.append(lon)
        
        
        ServerManager.sharedInstance.login(with: log, { (resp) in
            if resp.status == "success" {
                UserDefaults.standard.set(self.txtUsername.text!, forKey: "username")
                UserDefaults.standard.set(self.txtPassword.text!, forKey: "password")
                self.presentController()
            } else {
                self.lblError.text = resp.info
            }
        }, error: showErrorAlert)
    }
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    let locationManager = CLLocationManager()
    
    var lat = "0"
    var lon = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.lblError.text = ""
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if lat != "0" {
            return
        }
        
        if let location = manager.location {
            let locValue:CLLocationCoordinate2D = location.coordinate
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.lat = "\(locValue.latitude)"
            self.lon = "\(locValue.longitude)"
        }
    }
    
    func presentController() {
        let revealVC = SWRevealViewController()

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sideBar  = storyboard.instantiateViewController(withIdentifier: "SideBarVC")
        
        let vc = storyboard.instantiateViewController(withIdentifier: "sendMessage")
        revealVC.setRear(sideBar, animated: false)
        revealVC.setFront(vc, animated: false)
        self.present(revealVC, animated: false, completion: nil)
    }
    
}
