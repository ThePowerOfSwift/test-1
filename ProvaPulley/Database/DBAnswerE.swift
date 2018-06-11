//
//  DBAnswerE.swift
//  PerfectTemplate

//  Created by Giorgio on 01/06/2018.


import Foundation


class DBAnswerE: Codable{
    var idAnswer:Int32?
    var text:String?
    var timestamp:String?
    var event:DBEvent?
    var userOwner:DBUser?
    init(){
        
    }
   
}
