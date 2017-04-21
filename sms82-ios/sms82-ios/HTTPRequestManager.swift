//
//  HTTPRequestManager.swift
//  sms82-ios
//
//  Created by Niko on 4/21/17.
//  Copyright © 2017 Niko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HTTPRequestManager {
    
    let url = "https://sms82.herokuapp.com/"
    
    private func request(method: HTTPMethod, api: String, parameters: [String: Any]?, completion: @escaping (JSON)-> Void, error: @escaping (String)-> Void) {
        
        let APIaddress = "\(url)\(api)"
        
       // let header: HTTPHeaders = ["Authentification": "Basic dGVzdDoxMjNxd2UxMjM="]
        var header: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: "test", password: "123qwe123") {
            header[authorizationHeader.key] = authorizationHeader.value
        }
        
        Alamofire.request(APIaddress, method: method, parameters: parameters, encoding: JSONEncoding.default , headers: header)
            .responseJSON { (response:DataResponse<Any>) in
            
            if !(response.response != nil) {
                if response.result.isFailure {
                    if (response.error != nil) {
                        error((response.error?.localizedDescription)!)
                    } else {
                        
                        error("Не удалось загрузить данные. Вероятно, соединение с Интернетом прервано.")
                    }
                    return
                }
            }
            
            
            let statusCode: NSInteger = (response.response?.statusCode)!
            
            print("status code: \(statusCode)")
            
            if  statusCode == 401 {
                error("Вам нужно войти, чтобы выполнить это действие")
                return
            }
            
            
            let statusInt =  statusCode / 100
            
            
            switch(statusInt) {
            case 2:
                let json = JSON(data: response.data!)
                completion(json)
                break
            case 4:
                let json = JSON(data: response.data!)
                if !json.isEmpty {
                    print(json)
                    let message = json.stringValue
                    error(message)
                } else {
                    if let data = response.data {
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        error(json!)
                    } else {
                        error("")
                    }
                }
            default:
                if (response.result.error?.localizedDescription) != nil{
                    error((response.result.error?.localizedDescription)!)
                } else {
                    error("Ooops!")
                }
                break
            }
        }
    }
    
    
    internal func post(api: String, parameters: [String: Any], completion: @escaping (JSON)-> Void, error: @escaping (String)-> Void) {
        request(method: .post, api: api, parameters: parameters, completion: completion, error: error)
    }
    internal func delete(api: String, parameters: [String: Any], completion: @escaping (JSON)-> Void, error: @escaping (String)-> Void) {
        request(method: .delete, api: api, parameters: parameters, completion: completion, error: error)
    }
    internal func put(api: String, parameters: [String: Any], completion: @escaping (JSON)-> Void, error: @escaping (String)-> Void) {
        request(method: .put, api: api, parameters: parameters, completion: completion, error: error)
    }
    internal func get(api: String, completion: @escaping (JSON)-> Void, error: @escaping (String)-> Void) {
        request(method: .get, api: api, parameters: nil, completion: completion, error: error)
    }
    
}
