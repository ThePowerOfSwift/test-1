//
//  DentroLaChatViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 19/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

import JSQMessagesViewController

struct User3 {
    let id: String
    let name: String
}

class DentroLaChatViewController: JSQMessagesViewController {
    let user1 = User3(id: "1", name: "Steve")
    let user2 = User3(id: "2", name: "Tim")
    
    
    var currentUser: User3 {
        return user1
    }
    
    // all messages of users1, users2
    var messages = [JSQMessage]()
}

extension DentroLaChatViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        messages.append(message!)
        
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUsername = message.senderDisplayName
        
        return NSAttributedString(string: messageUsername!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let message = messages[indexPath.row]
        
        if currentUser.id == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 229/255.0, green: 229/255.0, blue: 231/255.0, alpha: 1))
        } else {
            return bubbleFactory?.incomingMessagesBubbleImage(with: DataManager.shared.sfondoColor)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
}

extension DentroLaChatViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tell JSQMessagesViewController
        // who is the current user
        self.senderId = currentUser.id
        self.senderDisplayName = SingletonServer.singleton.user?.nickname
        
        self.navigationItem.title = DataManager.shared.titolo
    
    

        
//        self.messages = getMessages()
    }
}

//extension DentroLaChatViewController {
//    func getMessages() -> [JSQMessage] {
//        var messages = [JSQMessage]()
//
//        let message1 = JSQMessage(senderId: "1", displayName: SingletonServer.singleton.user?.nickname, text: "Hey Tim how are you?")
//        let message2 = JSQMessage(senderId: "2", displayName: DataManager.shared.nomeUtente, text: "Fine thanks, and you?")
//
//        messages.append(message1!)
//        messages.append(message2!)
//
//        return messages
//    }
//}

