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
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    let locationManager = CLLocationManager()
    
    var lat = "0"
    var lon = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.title = "Authentification"
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
    
    @IBAction func Login(_ sender: Any) {
        
        let log = LoginModel()
        log.login = self.txtUsername.text!
        log.password = self.txtPassword.text!
        log.device_id = DataManager.shared.getDeviceID()
        log.geolocation.append(lat)
        log.geolocation.append(lon)
        
        ServerManager.sharedInstance.login(with: log, { (resp) in
            if resp.status == "success" {
                DataManager.shared.setUsername(self.txtUsername.text!)
                DataManager.shared.setPassord(self.txtPassword.text!)
                self.presentController()
            } else {
                self.lblError.text = resp.info
            }
        }, error: showErrorAlert)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            let locValue:CLLocationCoordinate2D = location.coordinate
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.lat = "\(locValue.latitude)"
            self.lon = "\(locValue.longitude)"
            manager.stopUpdatingLocation()
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
