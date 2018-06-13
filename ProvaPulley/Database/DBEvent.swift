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
    init(name:String,description:String, media:String,address:String, radar:DBRadar, user:DBUser,datetime:String, endDate:String,//mese:String, giorno:String, oraInizio:String, oraFine:String,
        topic:Int32){
        
        
        self.name =  name
        self.description = description
        self.datetime = datetime//"2018-\(mese)-\(giorno) \(oraInizio):00:00"
        self.endDate = endDate//"2018-\(mese)-\(giorno) \(oraFine):00:00"
        self.media = media
        self.address = address
        self.topic = topic
        self.ownerUser = user
        self.myPosition = radar
    }
    
    init(name:String,description:String, media:String,address:String, radar:DBRadar, user:DBUser, oraFine:String, topic:Int32){
        let date = Date()
        let calendar = Calendar.current
        var month = calendar.component(.month, from: date)
        var day = calendar.component(.day, from: date)
        let dataFine:String
        if month<10 && day<10{
            dataFine = "2018-0\(month)-0\(day) \(oraFine):00:00"
        }
        else if month<10 {
            dataFine = "2018-0\(month)-\(day) \(oraFine):00:00"
        }else if day<10 {
            dataFine = "2018-\(month)-0\(day) \(oraFine):00:00"
        }else {
            dataFine = "2018-\(month)-\(day) \(oraFine):00:00"
        }
        self.name =  name
        self.description = description
        
        self.endDate = dataFine
        self.media = media
        self.address = address
        self.topic = topic
        self.ownerUser = user
        self.myPosition = radar
    }
    
    init(name:String,mese:String, giorno:String, oraInizio:String, oraFine:String, topic:Int32, radar:DBRadar, user:DBUser){
        let dataInizio = "2018-\(mese)-\(giorno) \(oraInizio):00:00"
        let dataFine = "2018-\(mese)-\(giorno) \(oraFine):00:00"
        
        self.name =  name
        
        self.datetime = dataInizio
        self.endDate = dataFine
        
        self.topic = topic
        self.ownerUser = user
        self.myPosition = radar
    }
    
    init(name:String, oraFine:String,radar:DBRadar, user:DBUser, topic:Int32){
        let date = Date()
        let calendar = Calendar.current
        var month = calendar.component(.month, from: date)
        var day = calendar.component(.day, from: date)
        let dataFine:String
        if month<10 && day<10{
            dataFine = "2018-0\(month)-0\(day) \(oraFine):00:00"
        }
        else if month<10 {
            dataFine = "2018-0\(month)-\(day) \(oraFine):00:00"
        }else if day<10 {
            dataFine = "2018-\(month)-0\(day) \(oraFine):00:00"
        }else {
            dataFine = "2018-\(month)-\(day) \(oraFine):00:00"
        }
        
        
        self.name =  name
        
        self.endDate = dataFine
        
        
        self.topic = topic
        self.ownerUser = user
        self.myPosition = radar
    }

    
    
    
    
}
