//
//  DentroLaChatViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 19/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import Foundation

import JSQMessagesViewController


struct User3 {
    let id: String
    let name: String
}

class DentroLaChatViewController: JSQMessagesViewController {
    
    let user1 = User3(id: "1", name: "Steve")
    let user2 = User3(id: "2", name: "Tim")
    let rispostaQ = DBAnswerQ()
    
    var currentUser: User3 {
        return user1
    }
//         all messages of users1, users2
    var index = SingletonServer.singleton.questionSelezionata?.index
  

    
    
    func appendAnswerQ(answer: DBAnswerQ) {
        SingletonServer.singleton.user?.myQuestions![(SingletonServer.singleton.questionSelezionata?.index!)!].answers?.append(answer)
    }
    func appendAnswerE(answer: DBAnswerE) {
        SingletonServer.singleton.user?.myEvents![(SingletonServer.singleton.questionSelezionata?.indexReal!)!].answers?.append(answer)
    }
    
}

extension DentroLaChatViewController {
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        print("PREMUTO SEND")
        
        if(SingletonServer.singleton.questionSelezionata?.tipo == tipoChat.myquestions.hashValue){
            print("1")
            let message =  DBAnswerQ()
            message.text = text
            message.userOwner = DBUser()
            message.userOwner?.email = SingletonServer.singleton.user?.email
            message.userOwner?.nickname = SingletonServer.singleton.user?.nickname
            message.timestamp = Date(timeIntervalSinceNow: 0).description
            self.appendAnswerQ(answer: message)
            SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
            self.collectionView.reloadData()
            finishSendingMessage()
            
            
            POST_ADDAnswerQ(text: text, questionID: (SingletonServer
                .singleton.questionSelezionata?.id)!) { (result) in
                    if(result != "0"){
                        print("OK Add message")
                        DispatchQueue.main.async {
                            
                            
                        }
                        
                        
                    }
                    
            }

            
            
        }else{
            let message =  DBAnswerE()
            message.text = text
            message.userOwner = DBUser()
            message.userOwner?.email = SingletonServer.singleton.user?.email
            message.userOwner?.nickname = SingletonServer.singleton.user?.nickname
            message.timestamp = Date(timeIntervalSinceNow: 0).description
            self.appendAnswerE(answer: message)
            SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
            self.collectionView.reloadData()
            finishSendingMessage()
            
            
            POST_ADDAnswerE(text: text, eventID: (SingletonServer
                .singleton.questionSelezionata?.id)!) { (result) in
                    if(result != "0"){
                        print("OK Add message")
                        DispatchQueue.main.async {
                            
                            
                        }
                        
                        
                    }
                    
            }
            
        }
        
                self.view.endEditing(true)
    }
        
        
        
//        finishSendingMessage()

    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat{
        
        return 14.0
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat{
        
        return 13
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        if(SingletonServer.singleton.questionSelezionata?.tipo == tipoChat.myquestions.hashValue){
            print("1")
            let message = self.returnAnswersQuestion()[indexPath.row]
            let messageUsername = message.userOwner?.nickname
            
            
            return NSAttributedString(string: messageUsername!)
        }else{
            print("2")
            let message = self.returnAnswerEvent()[indexPath.row]
            let messageUsername = message.userOwner?.nickname
            
            
            return NSAttributedString(string: messageUsername!)
            
        }
        
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        if(SingletonServer.singleton.questionSelezionata?.tipo == tipoChat.myquestions.hashValue){
            print("3")
            let message: JSQMessage = JSQMessage(senderId: self.returnAnswersQuestion()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswersQuestion()[indexPath.row].userOwner!.nickname, date: Date(timeIntervalSinceNow: 0), text: self.returnAnswersQuestion()[indexPath.row].text)
            //        return NSAttributedString(string: self.returnAnswers()[indexPath.row].text!)
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        }else{
            print("4")
            let message: JSQMessage = JSQMessage(senderId: self.returnAnswerEvent()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswerEvent()[indexPath.row].userOwner!.nickname, date: Date(timeIntervalSinceNow: 0), text: self.returnAnswerEvent()[indexPath.row].text)
            //        return NSAttributedString(string: self.returnAnswers()[indexPath.row].text!)
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
            
        }
        
      
      
    }

    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let image = JSQMessagesAvatarImage(avatarImage: DataManager.shared.avatar, highlightedImage: DataManager.shared.avatar, placeholderImage: DataManager.shared.avatar)
        return image
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        if(SingletonServer.singleton.questionSelezionata?.tipo == tipoChat.myquestions.hashValue){
            print("5")
            let message = self.returnAnswersQuestion()[indexPath.row]
            if currentUser.id == message.userOwner?.email {
                return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 228/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1))
            } else {
                return bubbleFactory?.incomingMessagesBubbleImage(with: DataManager.shared.sfondoColor)
            }
        }else{
            print("6")
            let message = self.returnAnswerEvent()[indexPath.row]
            if currentUser.id == message.userOwner?.email {
                return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 228/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1))
            } else {
                return bubbleFactory?.incomingMessagesBubbleImage(with: DataManager.shared.sfondoColor)
            }
            
            
        }
        
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch(SingletonServer.singleton.questionSelezionata?.tipo){
//        case tipoChat.myquestions.hashValue:
//            print("7 Question")
//            return self.returnAnswersQuestion().count
//        case tipoChat.myevents.hashValue:
//            print("7 Question")
//            return self.returnAnswersQuestion().count
//            
//        default:
//            break
//            
//        }
        if(SingletonServer.singleton.questionSelezionata?.tipo == tipoChat.myquestions.hashValue){
            print("7 Question")
            return self.returnAnswersQuestion().count
        }else{
            print("8")
            return self.returnAnswerEvent().count

        }
        return self.returnAnswersQuestion().count
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        if(SingletonServer.singleton.questionSelezionata?.tipo == tipoChat.myquestions.hashValue){
            
            print("9")
            let message = JSQMessage(senderId: self.returnAnswersQuestion()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswersQuestion()[indexPath.row].userOwner!.nickname, date: Date(timeIntervalSinceNow: 0), text: self.returnAnswersQuestion()[indexPath.row].text)
            
            
            return message

        }else{
            print("10")
            let message = JSQMessage(senderId: self.returnAnswerEvent()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswerEvent()[indexPath.row].userOwner!.nickname, date: Date(timeIntervalSinceNow: 0), text: self.returnAnswerEvent()[indexPath.row].text)
            
            
            return message

            
        }
        
            }
    func returnAnswersQuestion() -> [DBAnswerQ] {
        let answers: [DBAnswerQ] = []
        if(SingletonServer.singleton.user?.myQuestions![(SingletonServer.singleton.questionSelezionata?.index!)!].answers != nil){
            return (SingletonServer.singleton.user?.myQuestions![(SingletonServer.singleton.questionSelezionata?.index!)!].answers)!
        }
        return answers
        
    }
    
    
    func returnAnswerEvent()->[DBAnswerE]{
        let answers: [DBAnswerE] = []
        if(SingletonServer.singleton.user?.myEvents![(SingletonServer.singleton.questionSelezionata?.indexReal!)!].answers != nil){
            return (SingletonServer.singleton.user?.myEvents![(SingletonServer.singleton.questionSelezionata?.indexReal!)!].answers)!
        }
        return answers
        
    }
}

extension DentroLaChatViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
//        // tell JSQMessagesViewController
//        // who is the current user
        self.senderId = currentUser.id
        self.senderDisplayName = SingletonServer.singleton.user?.nickname
//
//
//
        self.navigationItem.title = DataManager.shared.titolo
//
//
//
////        self.messages = getMessages()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataCollectionView), name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
    }
    
    @objc func reloadDataCollectionView(){
        print("CARICO CHAT")
        self.collectionView.reloadData()
    }
    
    override func dismissKeyboard() {
        self.collectionView.endEditing(true)
    }
}

//extension DentroLaChatViewController {
//    func getMessages() -> [JSQMessage] {
//        var messages = [JSQMessage]()
//
//        let date = Date()
//        let mess3 = JSQMessage(senderId: "1", senderDisplayName: SingletonServer.singleton.user?.nickname, date: date, text: "questa è ritardata")
//        let message1 = JSQMessage(senderId: "1", displayName: SingletonServer.singleton.user?.nickname, text: "Hey Tim how are you?")
//        let message2 = JSQMessage(senderId: "2", displayName: DataManager.shared.nomeUtente, text: "Fine thanks, and you?")
//
//        messages.append(message1!)
//        messages.append(message2!)
//
//        messages.append(mess3!)
//        return messages
//    }
//}
//

