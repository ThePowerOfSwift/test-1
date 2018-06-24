//
//  ChatTableViewCell.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var inizio: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var improf: UIImageView!
    @IBOutlet weak var sfondo: UICustomButton!
    
    var questionSelezionata:QSelezionata?
    
    
    @IBAction func clicco(_ sender: Any) {
//        DataManager.shared.sfondoColor = sfondo.backgroundColor!
//            DataManager.shared.titolo = desc.text!
//        DataManager.shared.nomeUtente = nickname.text!
//        DataManager.shared.avatar = improf.image!
        
//        for a in (SingletonServer.singleton.user?.myQuestions![(questionSelezionata?.index!)!].answers!)!{
//            print ("RISPOSTA:\(a.text)")
        
//        }
        
        
        if(questionSelezionata?.id != nil){
            if SingletonServer.singleton.user?.myQuestions![(questionSelezionata?.index!)!].answers == nil {
                SingletonServer.singleton.user?.myQuestions![(questionSelezionata?.index!)!].answers = []
            }
            for a in (SingletonServer.singleton.user?.myQuestions![(questionSelezionata?.index!)!].answers!)!{
                print ("RISPOSTA:\(a.text)")
            }
            print("INDEX:\(questionSelezionata?.index)")
            SingletonServer.singleton.questionSelezionata = QSelezionata(id: (questionSelezionata?.id!)! , index: (questionSelezionata?.index!)!)
            print("INDEX ORIGINAL\(String(describing: SingletonServer.singleton.questionSelezionata?.index))")
        
           
           SingletonServer.singleton.GET_RichiediChatQuestion(idQuestion: (questionSelezionata?.id!)!) { (result) in
            
                let data  = result?.data(using: .utf8)
                let decoder = JSONDecoder()
                print("A FESS")
                do{
                    
                    var answers = try decoder.decode([DBAnswerQ].self, from: data!)
                    //faccio il reload data della collection view quando ottengo risposta dal server
                    SingletonServer.singleton.user?.myQuestions![(self.questionSelezionata?.index)!].answers = answers
                    DispatchQueue.main.async {
                        
                        print("ANSWERS:\(result)")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadDataCollectionView"), object: nil)
                        SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
                    }
                   
                    //adesso salvo le informazioni (essendo le mie domande) in memoria secodnaria
                    
                    
                    
                }catch{
                    print("Errore di serializzazione")
                    
                }
            }
            print("CIAO")
            
                   
        }
        
        //QUA DEVI FARE IL PERFORM SEGUE
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
//    func retrieveAnswersOfAQuestion(id:Int32)->[DBAnswerQ]{
////        se vuoi lavorare sincronizzato alla richiesta al server
//        print(id)
//        var answers:[DBAnswerQ] = []
//        SingletonServer.singleton.GET_RichiediChatQuestion(idQuestion: id) { (result) in
//
//            let data  = result?.data(using: .utf8)
//            let decoder = JSONDecoder()
//            do{
//                answers = try decoder.decode([DBAnswerQ].self, from: data!)
//
//            }catch{
//                print("Errore di serializzazione")
//
//            }
//
//        }
//        return answers
//
//
//    }

}

struct QSelezionata {
    var id: Int32?
    var index: Int?
    init(id: Int32, index: Int) {
        self.id = id
        self.index = index
    }
}

