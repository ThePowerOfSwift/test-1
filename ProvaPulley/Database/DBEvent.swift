//
//  DBEvent.swift
//  COpenSSL
//
//  Created by Giorgio on 27/05/2018.
//

import Foundation


class DBEvent: Codable{
    var id:Int32?
    var name:String?
    var description:String?
    var datetime:String?
    var endDate:String?
    var media:String?
    var address:String?
    var topic:Int32?
    var subscribers:[DBUser]?
    var answers: [DBAnswerE]?
    var ownerUser:DBUser?
    var myPosition:DBRadar?
    
    init( id:Int32, name:String, description:String, datetime:String, endDate:String, media:String, address:String, topic:Int32?){
        self.id = id
        self.name =  name
        self.description = description
        self.datetime = datetime
        self.endDate = endDate
        self.media = media
        self.address = address
        self.topic = topic
    }
    
    
    
    
}
