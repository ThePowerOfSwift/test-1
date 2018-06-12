//
//  ServerSingleton.swift
//  BatChat
//
//  Created by Silvia Pascucci on 07/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//


import UIKit
import Foundation
import MessageUI

class SingletonServer{
    static var singleton:SingletonServer = SingletonServer()
    var user:DBUser?
    var domande:DBQuestion?
    var events_questions_aroundPosition:Events_QuestionsInSpecificRadar?
    let ipServer = "10.20.49.196"
    
    var logoImage: [UIImage] = [#imageLiteral(resourceName: "Lorenzo"),#imageLiteral(resourceName: "Giorgio"),#imageLiteral(resourceName: "Hind"),#imageLiteral(resourceName: "Luca"),#imageLiteral(resourceName: "Sofia"),#imageLiteral(resourceName: "Antonio vero"),#imageLiteral(resourceName: "Antonio falso"),#imageLiteral(resourceName: "Francesco"),#imageLiteral(resourceName: "Silvia")]
    var colori: [UIColor] = [DataManager.shared.artColor, DataManager.shared.cityInfoColor, DataManager.shared.foodColor, DataManager.shared.nightlifeColor, DataManager.shared.shopsColor, DataManager.shared.tourismColor]
    
    init() {
        //sendMessagePOST(x:13,y:13)
        
    }
    
    
    func saveUserState(user:DBUser){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let data = try encoder.encode(user)
            let string = String(data: data, encoding: .utf8)
            saveUserState(json: string!, user: user)
        }catch{
            print("Errore di serializzazione")
        }
        
        
        
    }
    
    func saveUserState(json:String, user:DBUser){
        SingletonServer.singleton.user = user
        UserDefaults.standard.set(json, forKey: "user")
        
    }
    func saveEvents_QuestionsInSpecificRadarState(json:String, e_q:Events_QuestionsInSpecificRadar){
        SingletonServer.singleton.events_questions_aroundPosition = e_q
        UserDefaults.standard.set(json, forKey: "events_questions_aroundPosition")
        
    }
    
    
    
    func retrieveUserState()->DBUser{
        let a = UserDefaults.standard.value(forKey: "user")
        if(a != nil){
            let jsonString1 = a as! String
            let data: Data? = jsonString1.data(using: .utf8)
            let decoder = JSONDecoder()
            do{
                let user = try decoder.decode(DBUser.self, from: data!)
                SingletonServer.singleton.user = user
                return user
            }catch{
                return DBUser()
            }
        }else{
            return DBUser()
        }
    }
    func retrieveEvents_QuestionsInSpecificRadarState()->Events_QuestionsInSpecificRadar{
        let a = UserDefaults.standard.value(forKey: "events_questions_aroundPosition")
        if(a != nil){
            let jsonString1 = a as! String
            let data: Data? = jsonString1.data(using: .utf8)
            let decoder = JSONDecoder()
            do{
                let e_q = try decoder.decode(Events_QuestionsInSpecificRadar.self, from: data!)
                SingletonServer.singleton.events_questions_aroundPosition = e_q
                return e_q
            }catch{
                return Events_QuestionsInSpecificRadar()
            }
        }else{
            return Events_QuestionsInSpecificRadar()
        }
    }
    
    
    
    func removeUserState(){
        SingletonServer.singleton.user = DBUser()
        UserDefaults.standard.removeObject(forKey: "user")
    }
    func removeEvents_QuestionsInSpecificRadarState(){
        SingletonServer.singleton.events_questions_aroundPosition = Events_QuestionsInSpecificRadar()
        UserDefaults.standard.removeObject(forKey: "events_questions_aroundPosition")
    }
    
    
    
    
    
    
    
    
    func POST_insertNewEvent(event:DBEvent, completionHandler: @escaping(String?) -> Void){
        
        
        let httpMethod = "POST"
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let a = try encoder.encode(event)
            let stringBody = String(data: a, encoding: .utf8)
            
            let httpBody : String = stringBody!
            
            let textUrl : String = "http://\(ipServer):8181/Event/insertNewEvent/"
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
            print("Errore di serializzazione/LatoClient")
        }
        
        
    }
    
    
    
    
    
    func POST_insertNewQuestion(text:String, dateFine:String, userOwner:DBUser, radar:DBRadar, topic:Int32, completionHandler: @escaping(String?) -> Void){
        let question = DBQuestion(text: text, dateFine: dateFine, topic: topic, ownerUser: userOwner, myPosition: radar)
        let httpMethod = "POST"
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let a = try encoder.encode(question)
            let stringBody = String(data: a, encoding: .utf8)
            
            let httpBody : String = stringBody!
            
            let textUrl : String = "http://\(ipServer):8181/Question/insertNewQuestion/"
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
            print("Errore di serializzazione/LatoClient")
        }
        
        
    }
    
    
    func POST_log(email: String, password: String, completionHandler: @escaping(String?) -> Void) {
        let httpMethod = "POST"
        let httpBody : String = password
        
        let textUrl : String = "http://\(ipServer):8181/User/login/\(email)/"
        let url : URL = URL(string: textUrl)!
        let session : URLSession = URLSession.shared
        
        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpBody = httpBody.data(using: .utf8)
        urlRequest.httpMethod = httpMethod
        
        
        var s:String?
        //        let semaphore = DispatchSemaphore(value: 0)
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
    
    func POST_MyQuestions_Events(email: String, completionHandler: @escaping(String?) -> Void) {
        let httpMethod = "POST"
        let httpBody : String = ""
        
        let textUrl : String = "http://\(ipServer):8181/User/MyQuestions/\(email)/"
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
    
    
    func POST_Questions_EventsAroundPosition(radar:DBRadar, completionHandler: @escaping(String?)->Void){
        let httpMethod = "POST"
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let a = try encoder.encode(radar)
            let stringBody = String(data: a, encoding: .utf8)
            
            let httpBody : String = stringBody!
            
            let textUrl : String = "http://\(ipServer):8181/Radar/retrieveFromRadar/EventsAndQuestions/"
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
            print("Errore di serializzazione/LatoClient")
        }
        
    }
    func provaRegistrazione(user:DBUser, completionHandler: @escaping(String?)->Void){
        let httpMethod = "POST"
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let a = try encoder.encode(user)
            let stringBody = String(data: a, encoding: .utf8)
            
            let httpBody : String = stringBody!
            
            let textUrl : String = "http://\(ipServer):8181/User/Register/Prova"
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
            print("Errore di serializzazione/LatoClient")
        }
        //        if MFMailComposeViewController.canSendMail() {
        //
        //            let mail = MyMessage()
        //            mail.messageComposeDelegate = mail
        //
        //
        //           mail.recipients = ["giorgio.fari96@gmail.com,lorenzocaso335@gmial.com"]
        //           mail.subject = "prova"
        //            mail.body = "CIAOO"
        //           mail.sendMessage()
        //
        //
        //
        //            } else {
        //                print("Errore! non posso inviare email")
        //                // INVIA UN MESSAGGIO ALL'UTENTE (AD ESEMPIO CON UNA ALERT VIEW)
        //            }
        
    }
    
    
    func sendMessagePOST(x:Double,y:Double,userEmail:String)->String{
        
        let httpMethod = "POST"
        let httpBody : String = userEmail
        
        let textUrl : String = "http://\(ipServer):8181/\(x)/\(y)"
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
struct Events_QuestionsInSpecificRadar:Codable{
    var questions:[DBQuestion]?
    var events:[DBEvent]?
    init(){
        
    }
    init(questions:[DBQuestion],events:[DBEvent]){
        self.questions = questions
        self.events = events
    }
    
}


func dateFromTimeout(timeout:Int)-> String{
    let date = Date()
    let calendar = Calendar.current
    var month = calendar.component(.month, from: date)
    var day = calendar.component(.day, from: date)
    var ora = calendar.component(.hour, from: date)
    var min = calendar.component(.minute, from: date)
    
    
    let dataFine:String
    if month<10 && day<10{
        dataFine = "2018-0\(month)-0\(day) \(ora+timeout):\(min):00"
    }
    else if month<10 {
        dataFine = "2018-0\(month)-\(day) \(ora+timeout):\(min):00"
    }else if day<10 {
        dataFine = "2018-\(month)-0\(day) \(ora+timeout):\(min):00"
    }else {
        dataFine = "2018-\(month)-\(day) \(ora+timeout):\(min):00"
    }
    print(dataFine)
    return dataFine
    
}

class MyMessage: MFMessageComposeViewController,MFMessageComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result{
            
        case .cancelled:
            print ("Invio dell'email cancellato dall'utente")
            break
            
            
            
        case .sent:
            print ("Email inviata correttamente")
            break
            
        case .failed:
            print ("Email non inviata, probabilmente a causa di un errore")
            break
            
        default:
            //questo caso non dovrebbe mai presentarsi!
            break
            
        }
    }
    func sendMessage(){
        
    }
    
    
}
        

