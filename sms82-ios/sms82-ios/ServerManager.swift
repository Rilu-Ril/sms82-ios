//
//  ServerManager.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerManager: HTTPRequestManager {
    
    class var sharedInstance: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
    
    func getMessages(_ completion: @escaping (Messages)-> Void, error: @escaping (String)-> Void) {
        let device_id = UserDefaults.standard.string(forKey: "devid")!
        self.get(api: "api/message/list?user_device_id=\(device_id)", completion: { (json) in
            let obj = Messages(json: json)
            completion(obj)},
                 error: error)
    }
    
    func getMessageDelails(by id:Int, completion: @escaping (MessageStatus)-> Void, error: @escaping (String)-> Void) {
        let device_id = UserDefaults.standard.string(forKey: "devid")!
        self.get(api: "api/message/\(id)?user_device_id=\(device_id)", completion: { (json) in
            let obj = MessageStatus(json: json)
            completion(obj)},
                 error: error)
    }
    
    func getBalance( completion: @escaping (Balance)-> Void, error: @escaping (String)-> Void) {
        let device_id = UserDefaults.standard.string(forKey: "devid")!
        self.get(api: "api/message/send?user_device_id=\(device_id)", completion: { (json) in
            let obj = Balance(json: json)
            completion(obj)},
                 error: error)
    }
    
    func login(with login: LoginModel, _ completion: @escaping (LoginResponse)-> Void, error: @escaping (String)-> Void) {
        
        let param = login.toDic()
        post(api: "api/message/login",
             parameters: param, completion: {(json) in
                let obj = LoginResponse(json: json)
                completion(obj)
        }, error: error)
    }
    
    func sendMessage(message: Info, _ completion: @escaping (Response)-> Void, error: @escaping (String)-> Void) {
        let param = message.toDict()
        
        post(api: "api/message/send",
             parameters: param, completion: {(json) in
                let obj = Response(json: json)
                
                completion(obj)
        }, error: error)
    }
}
