//
//  EventAnnotation.swift
//  BatChat
//
//  Created by Francesco Castelluccio on 14/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//


import Foundation
import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var image: UIImage!
    var topic:Int?
    
    
    var id:Int32?
    var name:String?
    var descri: String?
    var datetime:String?
    var endDate:String?
    var media:String?
    var address:String?
    
    var subscribers:[DBUser]?
    var answers: [DBAnswerE]?
    var ownerUser:DBUser?
    var myPosition:DBRadar?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
