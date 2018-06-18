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
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
