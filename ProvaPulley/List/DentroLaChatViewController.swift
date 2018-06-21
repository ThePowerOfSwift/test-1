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
    
    
    var currentUser: User3 {
        return user1
    }
    
    // all messages of users1, users2
    var messages = [JSQMessage]()
}

extension DentroLaChatViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        
        messages.append(message!)
        
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAt indexPath: IndexPath!) -> CGFloat{
        
        return 14.0
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat{
        
        return 13
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = messages[indexPath.row]
        let messageUsername = message.senderDisplayName
        
        
        return NSAttributedString(string: messageUsername!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message: JSQMessage = self.messages[indexPath.item]
        
        return JSQMessagesTimestampFormatter.shared().attributedTimestamp(for: message.date)
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
        
        let message = messages[indexPath.row]
        
        if currentUser.id == message.senderId {
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor(red: 228/255.0, green: 229/255.0, blue: 233/255.0, alpha: 1))
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
    
        
        
        self.messages = getMessages()
    }
}

extension DentroLaChatViewController {
    func getMessages() -> [JSQMessage] {
        var messages = [JSQMessage]()

        let date = Date()
        let mess3 = JSQMessage(senderId: "1", senderDisplayName: SingletonServer.singleton.user?.nickname, date: date, text: "questa è ritardata")
        let message1 = JSQMessage(senderId: "1", displayName: SingletonServer.singleton.user?.nickname, text: "Hey Tim how are you?")
        let message2 = JSQMessage(senderId: "2", displayName: DataManager.shared.nomeUtente, text: "Fine thanks, and you?")

        messages.append(message1!)
        messages.append(message2!)

        messages.append(mess3!)
        return messages
    }
}

