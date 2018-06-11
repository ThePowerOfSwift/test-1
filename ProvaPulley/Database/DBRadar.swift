//
//  DBRadar.swift
//  COpenSSL
//
//  Created by Giorgio on 26/05/2018.
//

import Foundation

class DBRadar: Codable{
    var posX:Double?
    var posY:Double?
    var range:Double?
    
    init( posX:Double,posY:Double, range:Double){
        self.posY = posY
        self.posX = posX
        self.range = range
    }
    init(){
        
        
    }
}
