//
//  Extensions.swift
//  
//
//  Created by Niko on 4/21/17.
//
//

import Foundation

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func alert(message: String, title: String = "", _ ok: @escaping ()-> Void, cancel: @escaping ()-> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in
            ok()
        })
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
            cancel()
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func setNavigationBar() {
        let revealVC =  self.revealViewController()
        if revealVC != nil {
            let leftButton = UIBarButtonItem(image: UIImage(named: "menu"),
                                             style: .plain,
                                             target: revealVC,
                                             action:  #selector(SWRevealViewController.revealToggle(_:)))
            
            self.navigationItem.leftBarButtonItem = leftButton
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
}

