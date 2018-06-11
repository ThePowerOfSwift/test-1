//
//  DBUser.swift
//  COpenSSL
//
//  Created by Giorgio on 24/05/2018.
//

import Foundation




class DBUser: Codable {
    var email:String?
    var nickname:String?
    var password:String?
    var socialAvatar:String?
    var token:String?
    var myQuestions:[DBQuestion]?
    var myEvents:[DBEvent]?
    
    init(email:String, nickname:String, password:String, socialAvatar: String, token:String) {
        self.email = email
        self.nickname = nickname
        self.password = password
        self.socialAvatar = socialAvatar
        self.token = token
    }
    init() {
        
    }
}
