//
//  ServerSingleton.swift
//  BatChat
//
//  Created by Silvia Pascucci on 07/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import Foundation

class SingletonServer{
    static var singleton:SingletonServer = SingletonServer()
    let ipServer = "10.20.49.196"
    init() {
        //sendMessagePOST(x:13,y:13)
        
    }
    
    //    func log(email: String, password: String, completionHandler: @escaping(String?) -> Void) {
    // invia la richiesta con i dati
    
    ////        session.dataTask(with: urlRequest) {
    ////            data, response, error in
    //        //          if error!= nil {
    ////        completionHandler(erro.locali)
    //    } else {
    //    completionHandler(data.string)
    //    }
    //
    //
    ////            guard error == nil else {
    ////                print(error)
    ////                complitionHandler(error.localize)
    ////            }
    ////            s = String(data: data!, encoding: .utf8)!
    ////            print(s)
    ////            }.resume()
    
    //    }
    
    //    func prova() {
    //        self.log(email: "ciao", password: "ciaociao") { (data) in
    //            <#code#>
    //        }
    //    }
    
    func login(email:String,password:String)->String{
        let httpMethod = "POST"
        let httpBody : String = password
        
        let textUrl : String = "http://10.20.49.196:8181/login/\(email)/"
        let url : URL = URL(string: textUrl)!
        let session : URLSession = URLSession.shared

        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody.data(using: .utf8)
        urlRequest.httpMethod = httpMethod
        
        var s3:String=""
        var s:String?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        
        session.dataTask(with: urlRequest) {
            data, response, error in
            
            guard error == nil else {
                print(error)
                return
            }
            
            
            
            s = String(data: data!, encoding: .utf8)!
            print(s)
            
            semaphore.signal()
            //                let decoder : JSONDecoder = JSONDecoder()
            //                do {
            //                    s1 = try decoder.decode(SiteMessage.self, from: data!).message
            ////                    print(s1)
            //                } catch {
            //                    return
            //                }
            //
            //            }
            
            }.resume()
        //            print(s)
        semaphore.wait()
        return s!
    }
    func sendMessagePOST(x:Double,y:Double,userEmail:String)->String{
        
        let httpMethod = "POST"
        let httpBody : String = userEmail
        
        let textUrl : String = "http://10.20.49.196:8181/\(x)/\(y)"
        let url : URL = URL(string: textUrl)!
        let session : URLSession = URLSession.shared
        
        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody.data(using: .utf8)
        urlRequest.httpMethod = httpMethod
        
        var s:String?
        var s1:String?
        
        session.dataTask(with: urlRequest) {
            data, response, error in
            
            guard error == nil else {
                print(error)
                return
            }
            DispatchQueue.main.async {
                s = String(data: data!, encoding: .utf8)!
                // print(s)
                
                let decoder : JSONDecoder = JSONDecoder()
                do {
                    s1 = try decoder.decode(SiteMessage.self, from: data!).message
                    //                    print(s1)
                } catch {
                    return
                }
            }
            }.resume()
        return s1!
    }
}

struct SiteMessage : Decodable {
    var success : Bool = false
    var message : String = ""
}
