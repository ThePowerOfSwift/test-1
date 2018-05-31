//
//  DataManager.swift
//  BatChat
//
//  Created by Antonio Terrano on 30/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

<<<<<<< HEAD
import Foundation
import UIKit
import MapKit
import CoreLocation

final class DataManager {
    
   static let shared = DataManager()
    
=======
import UIKit

final class DataManager {
    
    let shared = DataManager()
>>>>>>> acd63154e8917e706ab0e6fc5db9d6b51f64488c
    private init() {}

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
