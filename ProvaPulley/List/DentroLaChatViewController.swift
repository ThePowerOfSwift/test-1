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
    
    func appendAnswerQPulley(answer: DBAnswerQ) {
        
        SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.index!)!].answers?.append(answer)
    }
    func appendAnswerEPulley(answer: DBAnswerE) {
         SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.indexReal!)!].answers?.append(answer)
       
    }
    
}

extension DentroLaChatViewController {
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        print("PREMUTO SEND")
        
        switch SingletonServer.singleton.questionSelezionata?.tipo {
        case tipoChat.myquestions.hashValue:
            print("1")
            let message =  DBAnswerQ()
            message.text = text
            message.userOwner = DBUser()
            message.userOwner?.email = SingletonServer.singleton.user?.email
            message.userOwner?.nickname = SingletonServer.singleton.user?.nickname
          
            var dataFine =  Date(timeIntervalSinceNow: 0).description
            for _ in 1...6 {
                
                dataFine = String((dataFine.dropLast()))
            }
            message.timestamp = dataFine
            self.appendAnswerQ(answer: message)
            SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
            self.collectionView.reloadData()
            finishSendingMessage()
            
            
            POST_ADDAnswerQ(text: text, questionID: (SingletonServer
                .singleton.questionSelezionata?.id)!, timestamp: message.timestamp!) { (result) in
                    if(result != "0"){
                        print("OK Add message")
                        DispatchQueue.main.async {
                        }
                    }
            }
        case tipoChat.myevents.hashValue:
            let message =  DBAnswerE()
            message.text = text
            message.userOwner = DBUser()
            message.userOwner?.email = SingletonServer.singleton.user?.email
            message.userOwner?.nickname = SingletonServer.singleton.user?.nickname
            var dataFine =  Date(timeIntervalSinceNow: 0).description
            for _ in 1...6 {
                
                dataFine = String((dataFine.dropLast()))
            }
            message.timestamp = dataFine
            self.appendAnswerE(answer: message)
            SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
            self.collectionView.reloadData()
            finishSendingMessage()
            
            
            POST_ADDAnswerE(text: text, eventID: (SingletonServer
                .singleton.questionSelezionata?.id)!, timestamp: message.timestamp!) { (result) in
                    if(result != "0"){
                        print("OK Add message")
                        DispatchQueue.main.async {
                        }
                    }
            }
        case tipoChat.pulleyquestions.hashValue:
            print("1")
            let message =  DBAnswerQ()
            message.text = text
            message.userOwner = DBUser()
            message.userOwner?.email = SingletonServer.singleton.user?.email
            message.userOwner?.nickname = SingletonServer.singleton.user?.nickname
            var dataFine =  Date(timeIntervalSinceNow: 0).description
            for _ in 1...6 {
                
                dataFine = String((dataFine.dropLast()))
            }
            message.timestamp = dataFine
            self.appendAnswerQPulley(answer: message)
//            SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
            self.collectionView.reloadData()
            finishSendingMessage()
            
            
            POST_ADDAnswerQ(text: text, questionID: (SingletonServer
                .singleton.questionSelezionata?.id)!, timestamp: message.timestamp!) { (result) in
                    if(result != "0"){
                        print("OK Add message")
                        DispatchQueue.main.async {
                        }
                    }
            }
        default:
            print("ADD ANSWER PULLEY")
            let message =  DBAnswerE()
            message.text = text
            message.userOwner = DBUser()
            message.userOwner?.email = SingletonServer.singleton.user?.email
            message.userOwner?.nickname = SingletonServer.singleton.user?.nickname
            var dataFine =  Date(timeIntervalSinceNow: 0).description
            for _ in 1...6 {
                
                dataFine = String((dataFine.dropLast()))
            }
            message.timestamp = dataFine
            self.appendAnswerEPulley(answer: message)
//            SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
            self.collectionView.reloadData()
            finishSendingMessage()
            
            
            POST_ADDAnswerE(text: text, eventID: (SingletonServer
                .singleton.questionSelezionata?.id)!, timestamp: message.timestamp!) { (result) in
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
        
        switch SingletonServer.singleton.questionSelezionata?.tipo {
        case tipoChat.myquestions.hashValue:
            print("1 question")
            let message = self.returnAnswersQuestion()[indexPath.row]
            let messageUsername = message.userOwner?.nickname
            return NSAttributedString(string: messageUsername!)
        case tipoChat.myevents.hashValue:
            print("2 event")
            let message = self.returnAnswerEvent()[indexPath.row]
            let messageUsername = message.userOwner?.nickname
            return NSAttributedString(string: messageUsername!)
        case tipoChat.pulleyquestions.hashValue:
            print("1 questionPulley")
            let message = self.returnAnswersQuestionPulley()[indexPath.row]
            let messageUsername = message.userOwner?.nickname
            return NSAttributedString(string: messageUsername!)
        default:
            print("2 eventPulley")
            let message = self.returnAnswerEventPulley()[indexPath.row]
            let messageUsername = message.userOwner?.nickname
            return NSAttributedString(string: messageUsername!)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        
        switch SingletonServer.singleton.questionSelezionata?.tipo {
        case tipoChat.myquestions.hashValue:
            print("3")
            let message: JSQMessage = JSQMessage(senderId: self.returnAnswersQuestion()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswersQuestion()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswersQuestion()[indexPath.row].timestamp!), text: self.returnAnswersQuestion()[indexPath.row].text)
            //        return NSAttributedString(string: self.returnAnswers()[indexPath.row].text!)
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        case tipoChat.myevents.hashValue:
            print("4")
            let message: JSQMessage = JSQMessage(senderId: self.returnAnswerEvent()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswerEvent()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswerEvent()[indexPath.row].timestamp!), text: self.returnAnswerEvent()[indexPath.row].text)
            //        return NSAttributedString(string: self.returnAnswers()[indexPath.row].text!)
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        case tipoChat.pulleyquestions.hashValue:
            print("3")
            let message: JSQMessage = JSQMessage(senderId: self.returnAnswersQuestionPulley()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswersQuestionPulley()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswersQuestionPulley()[indexPath.row].timestamp!), text: self.returnAnswersQuestionPulley()[indexPath.row].text)
            //        return NSAttributedString(string: self.returnAnswers()[indexPath.row].text!)
            
            return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
        default:
            let message: JSQMessage = JSQMessage(senderId: self.returnAnswerEventPulley()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswerEventPulley()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswerEventPulley()[indexPath.row].timestamp!), text: self.returnAnswerEventPulley()[indexPath.row].text)
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
        
        switch SingletonServer.singleton.questionSelezionata?.tipo {
        case tipoChat.myquestions.hashValue:
            print("5")
            let message = self.returnAnswersQuestion()[indexPath.row]
            if self.senderId == message.userOwner?.email {
                return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 228/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1))
            } else {
                return bubbleFactory?.incomingMessagesBubbleImage(with:SingletonServer.singleton.coloroOn(topicNum:Int( (SingletonServer.singleton.user?.myQuestions![(SingletonServer.singleton.questionSelezionata?.index)!].topic)!)))
            }
        case tipoChat.myevents.hashValue:
            print("6")
            let message = self.returnAnswerEvent()[indexPath.row]
            if self.senderId == message.userOwner?.email {
                return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 228/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1))
            } else {
                return bubbleFactory?.incomingMessagesBubbleImage(with: SingletonServer.singleton.coloroOn(topicNum:Int( (SingletonServer.singleton.user?.myEvents![(SingletonServer.singleton.questionSelezionata?.indexReal)!].topic)!)))
            }
        case tipoChat.pulleyquestions.hashValue:
            print("5")
            let message = self.returnAnswersQuestionPulley()[indexPath.row]
            if self.senderId == message.userOwner?.email {
                return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 228/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1))
            } else {
                return bubbleFactory?.incomingMessagesBubbleImage(with:SingletonServer.singleton.coloroOn(topicNum:Int( (SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.index)!].topic)!)))
            }
        default:
            print("6")
            let message = self.returnAnswerEventPulley()[indexPath.row]
            if self.senderId == message.userOwner?.email {
                return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 228/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1))
            } else {
                return bubbleFactory?.incomingMessagesBubbleImage(with: SingletonServer.singleton.coloroOn(topicNum:Int( (SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.indexReal)!].topic)!)))
            }
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch(SingletonServer.singleton.questionSelezionata?.tipo){
        case tipoChat.myquestions.hashValue:
            print("7 Question")
            return self.returnAnswersQuestion().count
        case tipoChat.myevents.hashValue:
            print("8 Event")
            return self.returnAnswerEvent().count
        case tipoChat.pulleyquestions.hashValue:
            print("7 QuestionPulley")
            return self.returnAnswersQuestionPulley().count
        default:
            print("8 EventPulley")
            return self.returnAnswerEventPulley().count
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        switch SingletonServer.singleton.questionSelezionata?.tipo {
        case tipoChat.myquestions.hashValue:
            print("9")
            let message = JSQMessage(senderId: self.returnAnswersQuestion()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswersQuestion()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswersQuestion()[indexPath.row].timestamp!), text: self.returnAnswersQuestion()[indexPath.row].text)
            return message
        case tipoChat.myevents.hashValue:
            print("10")
            let message = JSQMessage(senderId: self.returnAnswerEvent()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswerEvent()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswerEvent()[indexPath.row].timestamp!), text: self.returnAnswerEvent()[indexPath.row].text)
            return message
        case tipoChat.pulleyquestions.hashValue:
            print("9")
            let message = JSQMessage(senderId: self.returnAnswersQuestionPulley()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswersQuestionPulley()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswersQuestionPulley()[indexPath.row].timestamp!), text: self.returnAnswersQuestionPulley()[indexPath.row].text)
            return message
        default:
            print("10")
            let message = JSQMessage(senderId: self.returnAnswerEventPulley()[indexPath.row].userOwner!.email, senderDisplayName: self.returnAnswerEventPulley()[indexPath.row].userOwner!.nickname, date: stringToDate(date: self.returnAnswerEventPulley()[indexPath.row].timestamp!), text: self.returnAnswerEventPulley()[indexPath.row].text)
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
    
    //esempio
    func returnAnswersQuestionPulley() -> [DBAnswerQ] {
        let answers: [DBAnswerQ] = []
        if(SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.index)!].answers != nil){
            return (SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.index)!].answers)!
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
    
    
    func returnAnswerEventPulley()->[DBAnswerE]{
        let answers: [DBAnswerE] = []
        if(SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.indexReal)!].answers != nil){
            return (SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(SingletonServer.singleton.questionSelezionata?.indexReal)!].answers)!
        }
        return answers
    }
    
}

extension DentroLaChatViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
//        // tell JSQMessagesViewController
//        // who is the current user
        self.senderId = SingletonServer.singleton.user?.email
        self.senderDisplayName = SingletonServer.singleton.user?.nickname
        self.navigationController?.isNavigationBarHidden = false
//
//
//
        self.tabBarController?.tabBar.isHidden = true

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

func stringToDate(date:String)->Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") as TimeZone!
    print(date)
    if(date != nil){
        let date = dateFormatter.date(from:date)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute , .second], from: date)
        let finalDate = calendar.date(from:components)
        return finalDate!
    }else{
        return Date(timeIntervalSinceNow: 0)
    }
    
}
