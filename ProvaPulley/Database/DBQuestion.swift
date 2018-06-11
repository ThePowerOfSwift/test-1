//
//  DBQuestion.swift
//  COpenSSL
//
//  Created by Giorgio on 27/05/2018.
//

import Foundation


class DBQuestion:Codable{
    var ID:Int32?
    var text:String?
    var dateFine:String?
    var timestamp:String?
    var topic:Int32?
    var subscribers:[DBUser]?
    var ownerUser: DBUser?
    var myPosition: DBRadar?
    var answers: [DBAnswerQ]?
    
    init(ID:Int32, text:String, dateFine:String, timestamp:String, topic:Int32) {
        self.ID = ID
        self.text = text
        self.dateFine = dateFine
        self.timestamp = timestamp
        self.topic = topic
    }
    init(text:String, dateFine:String, topic:Int32, ownerUser:DBUser, myPosition:DBRadar){
       
        self.text = text
        self.dateFine = dateFine
        
        self.topic = topic
        self.ownerUser = ownerUser
        self.myPosition = myPosition
    }
    
//    COSTRUTTORI
    
  
}
