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
        self.get(api: "api/message/list", completion: { (json) in
            let obj = Messages(json: json)
            completion(obj)},
                 error: error)
    }
    
    func getMessageDelails(by id:Int, completion: @escaping (MessagesStatus)-> Void, error: @escaping (String)-> Void) {
        self.get(api: "api/message/\(id)", completion: { (json) in
            let obj = MessagesStatus(json: json)
            completion(obj)},
                 error: error)
    }

    func getResponses(_ completion: @escaping (Responses)-> Void, error: @escaping (String)-> Void) {
        self.get(api: "api/message/send", completion: { (json) in
            let obj = Responses(json: json)
            completion(obj)},
                 error: error)
    }
    
    func sendMessage(message: Info, _ completion: @escaping ()-> Void, error: @escaping (String)-> Void) {
        let param = message.toDict()
        
        post(api: "api/message/send",
             parameters: param, completion: {(json) in
                completion()
        }, error: error)
    }
    
    
}
