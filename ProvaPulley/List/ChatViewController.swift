//
//  ChatViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    
    var messageTable = UITableView(frame: CGRect(x: 0, y: 510, width: 375, height: 685))
    
    
    var tableCount:Int = 0
    var countQuestion:Int?
    var topic = 0
    override func viewWillAppear(_ animated: Bool) {
//        let user = SingletonServer.singleton.retrieveUser()
//        if(user.email != nil){
//            updateMyQuestions_MyEventsWithCorrispectiveAnswers(email: user.email!)
//        }
        if(SingletonServer.singleton.questionSelezionata != nil){
            if((SingletonServer.singleton.questionSelezionata?.index)! < countQuestion!){
                POST_UnsubscribeToQuestion(id: (SingletonServer.singleton.questionSelezionata?.id)!) { (result) in
                    
                }
            }else{
                //unsubscribe di un evento
                
            }
        }
        self.tableview.reloadData()
        
        self.messageTable.reloadData()
    }
    

   
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        countQuestion = 0
        if( SingletonServer.singleton.user?.myQuestions != nil){
            count = (SingletonServer.singleton.user?.myQuestions?.count)!
            countQuestion = count
        }
        
        if( SingletonServer.singleton.user?.myEvents != nil){
            count = count + (SingletonServer.singleton.user?.myEvents?.count)!
        }
        return count
    }
    
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        tableView.isScrollEnabled = true
        
        self.messageTable.delegate = self
        
        self.messageTable.dataSource = self
        
        self.messageTable.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        self.messageTable.separatorStyle = .none
        
        self.view.addSubview(messageTable)
        
        
        
        if(indexPath.row<countQuestion!){
            let question = SingletonServer.singleton.user?.myQuestions![indexPath.row]
            let imgprof = SingletonServer.singleton.user?.socialAvatar! as! NSString
            let indexProf = imgprof.integerValue
            cell.improf?.image = SingletonServer.singleton.logoImage[indexProf]
            cell.sfondo?.backgroundColor = SingletonServer.singleton.coloroOn(topicNum: Int((question?.topic)!))
            cell.sfondo?.layer.cornerRadius = 32.0
            cell.sfondo?.layer.borderWidth = 1
            cell.sfondo?.layer.borderColor = SingletonServer.singleton.coloroOn(topicNum: Int((question?.topic)!)).cgColor
            cell.desc?.text = question?.text
            cell.desc?.textColor = .white
            cell.nickname?.text = SingletonServer.singleton.user?.nickname
            cell.nickname?.textColor = .white
            cell.nickname?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.num?.layer.cornerRadius = 12.0
            cell.num?.clipsToBounds = true
            if let _ = question?.answers?.count {
                cell.num?.text = "\(String(describing: question?.answers?.count))"
            } else {
                cell.num?.text = "0"
            }
            cell.num?.backgroundColor = .white
            cell.num?.textColor = SingletonServer.singleton.coloroOn(topicNum: Int((question?.topic)!))
            cell.num?.textAlignment = .center
            
            cell.inizio?.isHidden = true
            cell.inizio?.isHidden = false
            let dataFormat: String = String(String(question!.dateFine!.dropFirst(11)).dropLast(3))
            
            print("ORARIO VEDI QUI \(dataFormat)")
            
            cell.inizio?.text = dataFormat
            cell.inizio?.textColor = .white
            cell.questionSelezionata = QESelezionata(id: (question?.ID)!, index: indexPath.row, tipo: tipoChat.myquestions.hashValue, indexReal: indexPath.row)
            
            
        }else{
            let event = SingletonServer.singleton.user?.myEvents![indexPath.row-countQuestion!]
            
//            cell.improf?.image = SingletonServer.singleton.logoImage[Int((event?.topic!)!)]
            
            let indexProf = Int((event?.topic)!)
            cell.improf?.image = SingletonServer.singleton.logoEvent[indexProf]
            cell.sfondo?.backgroundColor = UIColor.white
            cell.sfondo?.layer.cornerRadius = 32.0
            cell.sfondo?.layer.borderWidth = 1
            cell.sfondo?.layer.borderColor = SingletonServer.singleton.coloroOn(topicNum: Int((event?.topic)!)).cgColor
            cell.desc?.text = event?.description
            cell.desc?.textColor = .black
            cell.nickname?.text = event?.name
            cell.nickname?.textColor = .black
            cell.nickname?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.num?.layer.cornerRadius = 12.0
            cell.num?.clipsToBounds = true
            if let _ = event?.answers?.count {
                cell.num?.text = "\(String(describing: event?.answers?.count))"
            } else {
                cell.num?.text = "0"
            }
            //                        cell.numero?.text = "\(String(describing: SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].answers?.count))"
            cell.num?.backgroundColor = SingletonServer.singleton.coloroOn(topicNum: Int((event?.topic!)!))
            cell.num?.textColor = .white
            cell.num?.textAlignment = .center
            
            cell.inizio?.isHidden = false
            
            
            
            let dataInitFormat: String = String(String(event!.datetime!.dropFirst(11)).dropLast(3))
            print("\(dataInitFormat) buuuuuuu")
            let dataEndFormat: String = String(String(event!.endDate!.dropFirst(11)).dropLast(3))
            print("\(dataEndFormat) bla bla")
            cell.inizio?.text =  "\(dataInitFormat) - \(dataEndFormat)"
            cell.inizio?.textColor = .black
            cell.questionSelezionata = QESelezionata(id: (event?.id)!, index: indexPath.row, tipo: tipoChat.myevents.hashValue, indexReal:indexPath.row-countQuestion! )
            
            
        }
        return cell
    }
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEWDIDLOAD")
       
       
        self.tableview.reloadData()
    
    }
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
