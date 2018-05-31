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


