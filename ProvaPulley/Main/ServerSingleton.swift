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
    
    
    // topic selezionato nella creazione di domande o eventi
    var chosenTopic: Int = 0
    var retrieveTopic:[Int] = []
    
    var user:DBUser?
    var eventoSelezionato: EventAnnotation?
    
    
    var questionSelezionata:QESelezionata?
    
    //if it's a skipper (anonimous user)
    var skipper: Bool = false
    
    
    var eventiOrdinatiPerTopic:[[DBEvent]] = [[DBEvent]]()
    var domandeOrdinatePerTopic:[[DBQuestion]] = [[DBQuestion]]()
    
    
    //    var events_questions_aroundPosition:Events_QuestionsInSpecificRadar?
    let ipServer = "151.73.41.110"
    
    var logoImage: [UIImage] = [#imageLiteral(resourceName: "Francesco"), #imageLiteral(resourceName: "Antonio vero"), #imageLiteral(resourceName: "Sofia"), #imageLiteral(resourceName: "Giorgio"), #imageLiteral(resourceName: "Hind"), #imageLiteral(resourceName: "Antonio falso"), #imageLiteral(resourceName: "Luca"), #imageLiteral(resourceName: "Lorenzo"), #imageLiteral(resourceName: "Silvia")]
    var colori: [UIColor] = [DataManager.shared.artColor, DataManager.shared.cityInfoColor, DataManager.shared.foodColor, DataManager.shared.nightlifeColor, DataManager.shared.shopsColor, DataManager.shared.tourismColor]
    
    
    
    func inizializza() {
        //sendMessagePOST(x:13,y:13)
        domandeOrdinatePerTopic = [[DBQuestion]]()
        domandeOrdinatePerTopic.append([DBQuestion]())
        domandeOrdinatePerTopic.append([DBQuestion]())
        domandeOrdinatePerTopic.append([DBQuestion]())
        domandeOrdinatePerTopic.append([DBQuestion]())
        domandeOrdinatePerTopic.append([DBQuestion]())
        domandeOrdinatePerTopic.append([DBQuestion]())
        domandeOrdinatePerTopic.append([DBQuestion]())
        
        eventiOrdinatiPerTopic = [[DBEvent]]()
        eventiOrdinatiPerTopic.append([DBEvent]())
        eventiOrdinatiPerTopic.append([DBEvent]())
        eventiOrdinatiPerTopic.append([DBEvent]())
        eventiOrdinatiPerTopic.append([DBEvent]())
        eventiOrdinatiPerTopic.append([DBEvent]())
        eventiOrdinatiPerTopic.append([DBEvent]())
        eventiOrdinatiPerTopic.append([DBEvent]())
        eventiOrdinatiPerTopic.append([DBEvent]())
        print("PORCO D")
    }
    
    
    func coloroOn( topicNum: Int)->UIColor {
        
        switch topicNum {
        case 0:
            return DataManager.shared.mainColor
        case 1:
            return DataManager.shared.foodColor
        case 2:
            return DataManager.shared.nightlifeColor
        case 3:
            return DataManager.shared.artColor
        case 4:
            return DataManager.shared.shopsColor
        case 5:
            return DataManager.shared.cityInfoColor
        case 6:
            return DataManager.shared.tourismColor
        default:
            print("")
            return UIColor.white
        }
        
    }
        
        func ordinaDomande(domande:[DBQuestion]){
            domandeOrdinatePerTopic = [[DBQuestion]]()
            domandeOrdinatePerTopic.append([DBQuestion]())
            domandeOrdinatePerTopic.append([DBQuestion]())
            domandeOrdinatePerTopic.append([DBQuestion]())
            domandeOrdinatePerTopic.append([DBQuestion]())
            domandeOrdinatePerTopic.append([DBQuestion]())
            domandeOrdinatePerTopic.append([DBQuestion]())
             domandeOrdinatePerTopic.append([DBQuestion]())
//            domandeOrdinatePerTopic[0] = []
//            domandeOrdinatePerTopic[1] = []
//            domandeOrdinatePerTopic[2] = []
//            domandeOrdinatePerTopic[3] = []
//            domandeOrdinatePerTopic[4] = []
//            domandeOrdinatePerTopic[5] = []
//            domandeOrdinatePerTopic[6] = []
            
            for domanda in domande{
                domandeOrdinatePerTopic[Int(domanda.topic!) ].append(domanda)
                domandeOrdinatePerTopic[0].append(domanda)
            }
        }
        
        
        func ordinaEventi(eventi:[DBEvent]){
            
            eventiOrdinatiPerTopic = [[DBEvent]]()
            eventiOrdinatiPerTopic.append([DBEvent]())
            eventiOrdinatiPerTopic.append([DBEvent]())
            eventiOrdinatiPerTopic.append([DBEvent]())
            eventiOrdinatiPerTopic.append([DBEvent]())
            eventiOrdinatiPerTopic.append([DBEvent]())
            eventiOrdinatiPerTopic.append([DBEvent]())
            eventiOrdinatiPerTopic.append([DBEvent]())
//            eventiOrdinatiPerTopic[0] = []
//            eventiOrdinatiPerTopic[1] = []
//            eventiOrdinatiPerTopic[2] = []
//            eventiOrdinatiPerTopic[3] = []
//            eventiOrdinatiPerTopic[4] = []
//            eventiOrdinatiPerTopic[5] = []
            
            for evento in eventi{
                eventiOrdinatiPerTopic[Int(evento.topic!) ].append(evento)
                eventiOrdinatiPerTopic[0].append(evento)
            }
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
        
        
    func POST_insertNewEventChat(event:DBEvent, completionHandler: @escaping(String?) -> Void){
        
        
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
    
    func GET_RichiediChatQuestion(idQuestion:Int32, completionHandler: @escaping(String?) -> Void){
        
        let httpMethod = "GET"
       
        let httpBody : String = ""
        let email = (SingletonServer.singleton.user?.email!)!
        
        let textUrl : String = "http://\(ipServer):8181/Question/Answers/\(idQuestion)/\(String(describing: email))/"
        
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
    
    func GET_RichiediChatEvent(idEvent:Int32, completionHandler: @escaping(String?) -> Void){
        
        let httpMethod = "GET"
        let httpBody : String = ""
        
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
    
//    func POST_ADDAnswerQ(text:String,questionID:Int32, email:String, completionHandler: @escaping(String?) -> Void){
//        let a = DBAnswerQ()
//        a.text = text
//        
//        a.question = DBQuestion()
//        a.question?.ID = questionID
//        a.userOwner = DBUser()
//        a.userOwner?.email = email
//        let httpMethod = "POST"
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//        do{
//            let data = try encoder.encode(a)
//            let string = String(data:data, encoding: .utf8)
//            
//            let httpBody : String = string!
//            
//            let textUrl : String = "http://\(ipServer):8181/Question/Answers/add/"
//            let url : URL = URL(string: textUrl)!
//            let session : URLSession = URLSession.shared
//            
//            var urlRequest : URLRequest = URLRequest(url: url)
//            urlRequest.httpBody = httpBody.data(using: .utf8)
//            urlRequest.httpMethod = httpMethod
//            
//            
//            var s:String?
//            session.dataTask(with: urlRequest) {
//                data, response, error in
//                if error != nil {
//                    print(error?.localizedDescription)
//                    completionHandler(error?.localizedDescription)
//                } else {
//                    s = String(data: data!, encoding: .utf8)!
//                    completionHandler(s)
//                }
//                }.resume()
//            
//        }catch{
//            print("errore di serializzazione")
//        }
//        
//        
//        
//        
//    }
    
    
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
        
        
        
        func removeUserState(){
            SingletonServer.singleton.user = DBUser()
            UserDefaults.standard.removeObject(forKey: "user")
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
            let user = DBUser()
            user.email = email
            // get a reference to the app delegate
            let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
            user.token = appDelegate?.returnToken()
            print("TOKEN: \(user.token!)")
            user.password = password
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            do{
                    let data = try encoder.encode(user)
                    let string = String(data: data, encoding: .utf8)
                    let httpMethod = "POST"
                    let httpBody : String = string!
                
                
                    let textUrl : String = "http://\(ipServer):8181/User/login/"
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
            }catch{
                print("Errore di serializzazione")
            }
            
            
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
                    print(error!)
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
            questions = [DBQuestion]()
            events = [DBEvent]()
            
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
    
    

    //    func saveEvents_QuestionsInSpecificRadarState(json:String, e_q:Events_QuestionsInSpecificRadar){
    //        SingletonServer.singleton.events_questions_aroundPosition = e_q
    //        UserDefaults.standard.set(json, forKey: "events_questions_aroundPosition")
    //
    //    }
    //
    //
    //    func removeEvents_QuestionsInSpecificRadarState(){
    //        SingletonServer.singleton.events_questions_aroundPosition = Events_QuestionsInSpecificRadar()
    //        UserDefaults.standard.removeObject(forKey: "events_questions_aroundPosition")
    //    }
    //    func retrieveEvents_QuestionsInSpecificRadarState()->Events_QuestionsInSpecificRadar{
    //        let a = UserDefaults.standard.value(forKey: "events_questions_aroundPosition")
    //        if(a != nil){
    //            let jsonString1 = a as! String
    //            let data: Data? = jsonString1.data(using: .utf8)
    //            let decoder = JSONDecoder()
    //            do{
    //                let e_q = try decoder.decode(Events_QuestionsInSpecificRadar.self, from: data!)
    //                SingletonServer.singleton.events_questions_aroundPosition = e_q
    //                return e_q
    //            }catch{
    //                return Events_QuestionsInSpecificRadar()
    //            }
    //        }else{
    //            return Events_QuestionsInSpecificRadar()
    //        }
    //    }
    //
    //    func saveEvents_QuestionsInSpecificRadarState(e_q:Events_QuestionsInSpecificRadar){
    //        let encoder = JSONEncoder()
    //        encoder.outputFormatting = .prettyPrinted
    //        do{
    //            let data = try encoder.encode(e_q)
    //            let string = String(data: data, encoding: .utf8)
    //            saveEvents_QuestionsInSpecificRadarState(json: string!, e_q: e_q)
    //        }catch{
    //            print("Errore di serializzazione")
    //        }
    //
    //
    //
    //    }
    //
    //
    
    

