//
//  DBEvent.swift
//  COpenSSL
//
//  Created by Giorgio on 27/05/2018.
//

import Foundation


class DBEvent{
    var id:Int32?
    var name:String?
    var description:String?
    var datetime:Any?
    var endDate:Any?
    var media:String?
    var address:String?
    var topic:Int32?
    var subscribers:[DBUser]?
    var answers: [DBAnswerE]?
    var ownerUser:DBUser?
    var myPosition:DBRadar?
    
    init(){
        
    }
    
    
    
    
}
