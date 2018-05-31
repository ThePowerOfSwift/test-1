//
//  DataManager.swift
//  BatChat
//
//  Created by Antonio Terrano on 30/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//


import Foundation
import UIKit
import MapKit
import CoreLocation



final class DataManager {
    
    private init() {}
    
    static let shared = DataManager()
    
    var profile = [#imageLiteral(resourceName: "Antonio falso"), #imageLiteral(resourceName: "Antonio vero"), #imageLiteral(resourceName: "Sofia"), #imageLiteral(resourceName: "Silvia"), #imageLiteral(resourceName: "Lorenzo"), #imageLiteral(resourceName: "Giorgio"), #imageLiteral(resourceName: "Luca"), #imageLiteral(resourceName: "Francesco")]

    var messages = [Message(author: User(nickname: "toni", imageNum: 2), message: "Blablablablabla", topic: .food),
                    Message(author: User(nickname: "toni", imageNum: 2), message: "bebebebebe", topic: .art),
                    Message(author: User(nickname: "toni", imageNum: 2), message: "Dove posso bebebebe", topic: .cityLife),
                    Message(author: User(nickname: "toni", imageNum: 2), message: "Blablablablabla", topic: .nightLife)]
}

class Message {
    init(author: User, message: String, topic: Topics) {
        self.author = author
        self.message = message
        self.topic = topic
    }
    let author: User
    let message: String
    let topic: Topics
}

class User {
    init(nickname: String, imageNum: Int) {
        self.nickname = nickname
        self.imageNum = imageNum
    }
    let nickname: String
    let imageNum: Int
}

enum Topics {
    case tourism
    case nightLife
    case food
    case art
    case cityLife
    case shops
    
}


