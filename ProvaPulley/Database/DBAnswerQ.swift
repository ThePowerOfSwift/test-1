//
//  DBAnswerQ.swift
//  COpenSSL
//
//  Created by Giorgio on 30/05/2018.
//

import Foundation


class DBAnswerQ: Codable{
    var text:String?
    var idAnswer:Int32?
    var timestamp:String?
    var question: DBQuestion?
    var userOwner:DBUser?
    
    
    init() {}

}
