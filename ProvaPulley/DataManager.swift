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
    
    let mainColor = UIColor.blue
    let foodColor = UIColor(red: 239.0/255.0, green: 139.0/255.0, blue: 95.0/255.0, alpha: 1)
    let nightlifeColor = UIColor(red: 233.0/255.0, green: 118.0/255.0, blue: 219.0/255.0, alpha: 1)
    let artColor = UIColor(red: 139.0/255.0, green: 149.0/255.0, blue: 215.0/255.0, alpha: 1)
    let shopsColor = UIColor(red: 221.0/255.0, green: 188.0/255.0, blue: 77.0/255.0, alpha: 1)
    let cityInfoColor = UIColor(red: 151.0/255.0, green: 201.0/255.0, blue: 112.0/255.0, alpha: 1)
    let tourismColor = UIColor(red: 197.0/255.0, green: 162.0/255.0, blue: 241.0/255.0, alpha: 1)
    
    var profile = [#imageLiteral(resourceName: "Antonio falso"), #imageLiteral(resourceName: "Antonio vero"), #imageLiteral(resourceName: "Sofia"), #imageLiteral(resourceName: "Silvia"), #imageLiteral(resourceName: "Lorenzo"), #imageLiteral(resourceName: "Giorgio"), #imageLiteral(resourceName: "Luca"), #imageLiteral(resourceName: "Francesco"), #imageLiteral(resourceName: "Hind")]
    
    var sfondoColor = UIColor.white

    var titolo = ""
    
    var nomeUtente = ""
    var messages = [Message(author: User(nickname: "toni", imageNum: 2), message: "Blablablablabla", topic: .food, id: true),
                    Message(author: User(nickname: "toni", imageNum: 2), message: "bebebebebe", topic: .art, id: false),
                    Message(author: User(nickname: "toni", imageNum: 2), message: "Dove posso bebebebe", topic: .cityLife, id: false),
                    Message(author: User(nickname: "toni", imageNum: 2), message: "Blablablablabla", topic: .nightLife, id: true)]
}

class Message {
    init(author: User, message: String, topic: Topics, id: Bool) {
        self.author = author
        self.message = message
        self.topic = topic
        self.id = id
    }
    let author: User
    let message: String
    let topic: Topics
    var id: Bool
}

class Event {
    
    init(title: String, description: String, topic: Topics,  id: Bool)
    {
        self.title = title
        self.description = description
        self.topic = topic
        
        self.id = id

    }
    
    let title: String
    let description: String
    let topic: Topics
   
    var id: Bool

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


