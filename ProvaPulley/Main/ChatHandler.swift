//
//  ChatHandler.swift
//  BatChat
//
//  Created by Antonio Caiazzo on 22/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import Foundation

let ipServer = SingletonServer.singleton.ipServer

func GET_RichiediChatQuestion(idQuestion:Int32, email:String, completionHandler: @escaping(String?) -> Void){
    
    let httpMethod = "GET"
    
    let httpBody : String = "\(email)"
    
    let textUrl : String = "http://\(ipServer):8181/Question/Answers/\(idQuestion)/"
    let url : URL = URL(string: textUrl)!
    let session : URLSession = URLSession.shared
    
    var urlRequest : URLRequest = URLRequest(url: url)
    urlRequest.httpBody = httpBody.data(using: .utf8)
    urlRequest.httpMethod = httpMethod
    
    
    var s:String?
    session.dataTask(with: urlRequest) {
        data, response, error in
        if error != nil {
            print(error?.localizedDescription)
            completionHandler(error?.localizedDescription)
        } else {
            s = String(data: data!, encoding: .utf8)!
            completionHandler(s)
        }
        }.resume()
    
    
    
}

func GET_RichiediChatEvent(idEvent:Int32,email:String, completionHandler: @escaping(String?) -> Void){
    
    let httpMethod = "GET"
    let httpBody : String = "\(email)"
    
    let textUrl : String = "http://\(ipServer):8181/Event/Answers/\(idEvent)"
    let url : URL = URL(string: textUrl)!
    let session : URLSession = URLSession.shared
    
    var urlRequest : URLRequest = URLRequest(url: url)
    urlRequest.httpBody = httpBody.data(using: .utf8)
    urlRequest.httpMethod = httpMethod
    
    
    var s:String?
    session.dataTask(with: urlRequest) {
        data, response, error in
        if error != nil {
            print(error?.localizedDescription)
            completionHandler(error?.localizedDescription)
        } else {
            s = String(data: data!, encoding: .utf8)!
            completionHandler(s)
        }
        }.resume()
}


func POST_ADDAnswerQ(text:String,questionID:Int32, email:String, completionHandler: @escaping(String?) -> Void){
    let a = DBAnswerQ()
    a.text = text
    
    a.question = DBQuestion()
    a.question?.ID = questionID
    a.userOwner = DBUser()
    a.userOwner?.email = SingletonServer.singleton.user?.email
    a.userOwner?.nickname = SingletonServer.singleton.user?.nickname
    a.userOwner?.socialAvatar = SingletonServer.singleton.user?.socialAvatar
    
    let httpMethod = "POST"
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do{
        let data = try encoder.encode(a)
        let string = String(data:data, encoding: .utf8)
        
        let httpBody : String = string!
        
        let textUrl : String = "http://\(ipServer):8181/Question/Answers/add/"
        let url : URL = URL(string: textUrl)!
        let session : URLSession = URLSession.shared
        
        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody.data(using: .utf8)
        urlRequest.httpMethod = httpMethod
        
        
        var s:String?
        session.dataTask(with: urlRequest) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                completionHandler(error?.localizedDescription)
            } else {
                s = String(data: data!, encoding: .utf8)!
                completionHandler(s)
            }
            }.resume()
        
    }catch{
        print("errore di serializzazione")
    }
    
}


func POST_ADDAnswerE(text:String,eventID:Int32, email:String, completionHandler: @escaping(String?) -> Void){
    let a = DBAnswerE()
    a.text = text
    a.event = DBEvent()
    a.event?.id = eventID
    a.userOwner = DBUser()
    a.userOwner?.email = email
    let httpMethod = "POST"
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do{
        let data = try encoder.encode(a)
        let string = String(data:data, encoding: .utf8)
        
        let httpBody : String = string!
        
        let textUrl : String = "http://\(ipServer):8181/Event/Answers/add/"
        let url : URL = URL(string: textUrl)!
        let session : URLSession = URLSession.shared
        
        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody.data(using: .utf8)
        urlRequest.httpMethod = httpMethod
        
        
        var s:String?
        session.dataTask(with: urlRequest) {
            data, response, error in
            if error != nil {
                print(error?.localizedDescription)
                completionHandler(error?.localizedDescription)
            } else {
                s = String(data: data!, encoding: .utf8)!
                completionHandler(s)
            }
            }.resume()
        
    }catch{
        print("errore di serializzazione")
    }
}


func retrieveAnswersOfAQuestion(id:Int32, email:String)->[DBAnswerQ]{
    
    print(id)
    var answers:[DBAnswerQ] = []
    GET_RichiediChatQuestion(idQuestion: id, email: email) { (result) in
        
        let data  = result?.data(using: .utf8)
        let decoder = JSONDecoder()
        do{
            answers = try decoder.decode([DBAnswerQ].self, from: data!)
            
        }catch{
            print("Errore di serializzazione")
            
        }
        
    }
    return answers
    
    
}


func retrieveAnswersOfAEvent(id:Int32, email:String)->[DBAnswerE]{
    
    print(id)
    var answers:[DBAnswerE] = []
    GET_RichiediChatEvent(idEvent: id, email: email) { (result) in
        let data  = result?.data(using: .utf8)
        let decoder = JSONDecoder()
        do{
            answers = try decoder.decode([DBAnswerE].self, from: data!)
            
        }catch{
            print("Errore di serializzazione")
            
        }
    }
    
    return answers
    
}
