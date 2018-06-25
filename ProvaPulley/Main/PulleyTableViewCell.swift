//
//  PulleyTableViewCell.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class PulleyTableViewCell: UITableViewCell {
    
    var backView: UIButton?
    var improf: UIImageView?
    var nickname: UILabel?
    var descrizione: UILabel?
    var data: UILabel?
    var dataEvent: UILabel?
    var numero: UILabel?
    var questionSelezionata: QESelezionata?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        backView = UIButton()
        self.backView?.addTarget(self, action: #selector(performeQuest), for: .touchDown)
        nickname = UILabel(frame: CGRect(x: 85, y: 8, width: 79, height: 18))
        improf = UIImageView(frame: CGRect(x: 8, y: 6, width: 60, height: 60))
        backView = UIButton(frame: CGRect(x: 5, y: 3, width: 360, height: 65))
        
        descrizione = UILabel(frame: CGRect(x: 85, y: 25, width: 196, height: 40))
        data = UILabel(frame: CGRect(x: 270, y: 8, width: 50, height: 15))
        dataEvent = UILabel(frame: CGRect(x: 190, y: 8, width: 110, height: 15))
        numero = UILabel(frame: CGRect(x: 325, y: 20, width: 25, height: 25))
        
        self.addSubview(backView!)
        self.addSubview(nickname!)
        self.addSubview(improf!)
        self.addSubview(descrizione!)
        self.addSubview(numero!)
        self.addSubview(data!)
        self.addSubview(dataEvent!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func tapMessage(button: UIButton) {
        
        
    }
    
    
    @objc func performeQuest(){
        print("ENTRATO")
        DataManager.shared.sfondoColor = (backView?.backgroundColor!)!
        DataManager.shared.titolo = (descrizione?.text!)!
        DataManager.shared.nomeUtente = (nickname?.text!)!
        DataManager.shared.avatar = (improf?.image!)!
        
        
        if(questionSelezionata?.id != nil){
            switch(questionSelezionata?.tipo){
                
            case tipoChat.pulleyquestions.hashValue:
                //QUESTION
                print("QUESTION v")
                if SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(questionSelezionata?.index!)!].answers == nil {
                    SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(questionSelezionata?.index!)!].answers = []
                }
                for a in (SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(questionSelezionata?.index!)!].answers!){
                    print ("RISPOSTA:\(a.text)")
                }
                print("INDEX:\(questionSelezionata?.index)")
                SingletonServer.singleton.questionSelezionata = QESelezionata(id: (questionSelezionata?.id!)! , index: (questionSelezionata?.index!)!, tipo: tipoChat.pulleyquestions.hashValue, indexReal: (questionSelezionata?.indexReal)!)
                print("INDEX ORIGINAL\(String(describing: SingletonServer.singleton.questionSelezionata?.index))")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "perfDentro"), object: nil)

                richiediChatQuestionPulley(idQuestion: (SingletonServer.singleton.questionSelezionata?.id)!)
                //richiediChatQuestion(idQuestion:(questionSelezionata?.id)!)
                
            case tipoChat.pulleyevents.hashValue:
                //EVENTO
                print("QUESTION v")
                if SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(questionSelezionata?.indexReal!)!].answers == nil {
                    SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(questionSelezionata?.indexReal!)!].answers = []
                }
                for a in (SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(questionSelezionata?.indexReal!)!].answers!){
                    print ("RISPOSTA:\(a.text)")
                }
                print("INDEX:\(questionSelezionata?.index)")
                SingletonServer.singleton.questionSelezionata = QESelezionata(id: (questionSelezionata?.id!)! , index: (questionSelezionata?.index!)!, tipo: tipoChat.pulleyevents.hashValue, indexReal: (questionSelezionata?.indexReal)!)
                print("INDEX ORIGINAL\(String(describing: SingletonServer.singleton.questionSelezionata?.index))")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "perfDentro"), object: nil)
                richiediChatEventPulley(idEvent: (SingletonServer.singleton.questionSelezionata?.id)!)
                
                
            default:
                print("NIENTE")
            }
            
            
            
            
            
            
            
            
        }
//        self.performSegue(withIdentifier: "seguePulleyMessage", sender: nil)
//        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
    
    func richiediChatQuestionPulley(idQuestion:Int32){
        SingletonServer.singleton.GET_RichiediChatQuestion(idQuestion:idQuestion) { (result) in
            
            let data  = result?.data(using: .utf8)
            let decoder = JSONDecoder()
            print("A FESS")
            do{
                
                var answers = try decoder.decode([DBAnswerQ].self, from: data!)
                //faccio il reload data della collection view quando ottengo risposta dal server
                
                DispatchQueue.main.async {
                    SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][(self.questionSelezionata?.index!)!].answers = answers
                    print("ANSWERS:\(result)")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
                    //SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
                }
                
                //adesso salvo le informazioni (essendo le mie domande) in memoria secodnaria
                
                
                
            }catch{
                print("Errore di serializzazione")
                
            }
        }
    }
    
    
    func richiediChatEventPulley(idEvent:Int32){
        SingletonServer.singleton.GET_RichiediChatEvent(idEvent:idEvent) { (result) in
            
            let data  = result?.data(using: .utf8)
            let decoder = JSONDecoder()
            print("A FESS")
            do{
                
                var answers = try decoder.decode([DBAnswerE].self, from: data!)
                //faccio il reload data della collection view quando ottengo risposta dal server
                
                DispatchQueue.main.async {
                    SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][(self.questionSelezionata?.indexReal!)!].answers = answers
                    print("ANSWERS:\(result)")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
                    //SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
                }
                
                //adesso salvo le informazioni (essendo le mie domande) in memoria secodnaria
                
                
                
            }catch{
                print("Errore di serializzazione")
                
            }
        }
    }
    
    
}

