//
//  PuViewController.swift
//  ProvaPulley
//
//  Created by Lorenzo Caso on 22/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import Pulley
import QuartzCore



class DrawerContentViewController: UIViewController, UITabBarDelegate, UITableViewDelegate{
    
    var topic = 0
    
    @IBOutlet weak var Send: UIButton!
    @IBOutlet weak var Gripper: UIView!
    @IBOutlet weak var AskQuestionTextField: UITextField!
    
    @IBOutlet weak var AnyButton: UICustomButton!
    @IBOutlet weak var TourismButton: UICustomButton!
    @IBOutlet weak var NightLifeButton: UICustomButton!
    @IBOutlet weak var FoodButton: UICustomButton!
    @IBOutlet weak var ArtButton: UICustomButton!
    @IBOutlet weak var CityInfoButton: UICustomButton!

    @IBOutlet weak var Tourism2Button: UICustomButton!
    
    var messageTable = UITableView(frame: CGRect(x: 0, y: 120, width: 375, height: 500))

    var topicBool: [Bool] = [true, false, false, false, false, false, false]
    var tableCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.Gripper.layer.cornerRadius = 3
        
//      tableView
        self.messageTable.delegate = self
        
        self.messageTable.dataSource = self
        
        self.messageTable.register(PulleyTableViewCell.self, forCellReuseIdentifier: "cell")
        self.messageTable.separatorStyle = .none
        
        self.view.addSubview(messageTable)
        
//      topic buttons
        AnyButton.borderColor = UIColor.gray.cgColor
        CityInfoButton.borderColor = UIColor.gray.cgColor
        Tourism2Button.borderColor = UIColor.gray.cgColor
        TourismButton.borderColor = UIColor.gray.cgColor
        ArtButton.borderColor = UIColor.gray.cgColor
        NightLifeButton.borderColor = UIColor.gray.cgColor
        FoodButton.borderColor = UIColor.gray.cgColor
        
        setupTable()
    }
    
    
    func setupTable() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name(rawValue: "data"), object: nil)
        
        
    }
    
    @objc func reload() {
        self.messageTable.reloadData()
        print("CIAO££kdkskksk")
        dismissKeyboard()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
          
     
    }

    @IBAction func askQuestion(_ sender: Any) {
        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
    
    
    @IBAction func Cancel(_ sender: Any) {
        dismissKeyboard()
        
        let user = SingletonServer.singleton.user
        let radar = SingletonServer.singleton.user?.posFit
        let data = dateFromTimeout(timeout: 3)
        print(data)
        self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        SingletonServer.singleton.POST_insertNewQuestion(text: AskQuestionTextField.text!, dateFine: data, userOwner: user!, radar: radar!, topic: 1) { (result) in
            let decoder = JSONDecoder()
            let da = result?.data(using: .utf8)
            do{
                let question = try decoder.decode(DBQuestion.self, from: da!)
                if(question.ID != nil){
//                    SingletonServer.singleton.user?.myQuestions?.append(question)
//                    SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
//                    SingletonServer.singleton.events_questions_aroundPosition?.questions?.append(question)
//                    SingletonServer.singleton.saveEvents_QuestionsInSpecificRadarState(e_q: SingletonServer.singleton.events_questions_aroundPosition!)
                    
                    SingletonServer.singleton.user?.myQuestions?.append(question)
                    SingletonServer.singleton.domandeOrdinatePerTopic[Int(question.topic!)].append(question)
//
                    print(question.text!)
                    
                }
            }catch{
                print("errore di serializzazione|LATOCLIENT")
               
            }
            
            
        }
    }
    
    
    @IBAction func anyButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 0
        self.messageTable.reloadData()
        if !topicBool[0] {
            for i in 1...6 {
                self.topicBool[i] = false
            }
            allButtonsOff()
            
            buttonOn(button: AnyButton, topicNum: 0)
            topicBool[0] = true
        }
        else {
            buttonOff(button: AnyButton)
            topicBool[0] = false
        }
        
    }
    
    @IBAction func foodButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 1
       
        self.messageTable.reloadData()
        if !topicBool[1] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: FoodButton, topicNum: 1)
            topicBool[1] = true
        }
        else {
            buttonOff(button: FoodButton)
            topicBool[1] = false
        }
    }
    
    @IBAction func nightlifeButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 2
        self.messageTable.reloadData()
        if !topicBool[2] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: NightLifeButton, topicNum: 2)
            topicBool[2] = true
        }
        else {
            buttonOff(button: NightLifeButton)
            topicBool[2] = false
        }
    }
    
    @IBAction func artButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 3
       self.messageTable.reloadData()
        if !topicBool[3] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: ArtButton, topicNum: 3)
            topicBool[3] = true
        }
        else {
            buttonOff(button: ArtButton)
            topicBool[3] = false
        }
    }
    
    @IBAction func Tourism2Tap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 4
        self.messageTable.reloadData()
        if !topicBool[4] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: Tourism2Button, topicNum: 4)
            topicBool[4] = true
        }
        else {
            buttonOff(button: Tourism2Button)
            topicBool[4] = false
        }
    }
    
    
    @IBAction func cityinfoButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 5
       self.messageTable.reloadData()
        
        if !topicBool[5] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: CityInfoButton, topicNum: 5)
            topicBool[5] = true
        }
        else {
            buttonOff(button: CityInfoButton)
            topicBool[5] = false
        }
    }
    
    @IBAction func tourismButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 6
        self.messageTable.reloadData()
        if !topicBool[6] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: TourismButton, topicNum: 6)
            topicBool[6] = true
        }
        else {
            buttonOff(button: TourismButton)
            topicBool[6] = false
        }
    }
    
}
extension DrawerContentViewController {
    private func buttonOn(button: UICustomButton, topicNum: Int) {
        
        switch topicNum {
        case 0:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.mainColor}))
        case 1:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.foodColor}))
        case 2:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.nightlifeColor}))
        case 3:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.artColor}))
        case 4:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.shopsColor}))
        case 5:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.cityInfoColor}))
        case 6:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.tourismColor}))
        default:
            print("")
        }
        
//            UIView.animate(withDuration: 0.3,
//
//                           animations: ({button.backgroundColor = UIColor.blue}))

            UIView.animate(withDuration: 0.3, animations: ({button.layer.borderColor = UIColor.white.cgColor}))
        
            UIView.animate(withDuration: 0.3, animations:  ({button.setTitleColor(UIColor.white, for: UIControlState.normal)}))
        
//        button.backgroundColor = UIColor.blue
//        button.layer.borderColor = UIColor.white.cgColor
//        button.setTitleColor(UIColor.white, for: UIControlState.normal)
    
}
/*
    se è un evento colori solo il bordo if-- switch
     se è una chat coloro tutto
*/
    
    private func buttonOff(button: UICustomButton) {
        
            UIView.animate(withDuration: 0.25,
                       
                       animations: ({button.backgroundColor = UIColor.white}))
        
            UIView.animate(withDuration: 0.25,
                       
                       animations: ({button.layer.borderColor = UIColor.gray.cgColor}))
        
        
            UIView.animate(withDuration: 0.25,
                       
                       animations: ({button.setTitleColor(UIColor.gray, for: UIControlState.normal)}))
        
//        button.backgroundColor = UIColor.white
//        button.layer.borderColor = UIColor.black.cgColor
//        button.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    private func allButtonsOff() {
        buttonOff(button: TourismButton)
        buttonOff(button: NightLifeButton)
        buttonOff(button: FoodButton)
        buttonOff(button: ArtButton)
        buttonOff(button: CityInfoButton)
        buttonOff(button: Tourism2Button)
    }
    
    
}


extension DrawerContentViewController: UITableViewDataSource {
    
    
    func switchTopic(topic:Int)->Int{
        var count = 0
 
                count = (SingletonServer.singleton.eventiOrdinatiPerTopic[topic].count)
                

                count = count+(SingletonServer.singleton.domandeOrdinatePerTopic[topic].count)

        
        self.tableCount = count
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topic = SingletonServer.singleton.chosenTopic
        let count = switchTopic(topic: topic)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PulleyTableViewCell
        if(indexPath.row<SingletonServer.singleton.domandeOrdinatePerTopic[topic].count){
                        let imgprof = SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.socialAvatar as! NSString
                        let indexProf = imgprof.integerValue as! Int
                        cell.improf?.image = SingletonServer.singleton.logoImage[topic]
                        cell.backView?.backgroundColor = SingletonServer.singleton.colori[topic]
                        cell.backView?.layer.cornerRadius = 32.0
                        cell.descrizione?.text = SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].text
                        cell.descrizione?.textColor = .white
                        cell.nickname?.text = SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.nickname
                        cell.nickname?.textColor = .white
                        cell.nickname?.font = UIFont.boldSystemFont(ofSize: 16.0)
                        cell.numero?.layer.cornerRadius = 12.0
                        cell.numero?.clipsToBounds = true
                        cell.numero?.text = "\(String(describing: SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].answers?.count))"
                        cell.numero?.backgroundColor = .white
                        cell.numero?.textColor = SingletonServer.singleton.colori[topic]
                        cell.numero?.textAlignment = .center
                        cell.data?.text =  SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].dateFine
                        cell.data?.textColor = .white
            
                        cell.backView?.addTarget(self, action: #selector(performeQuest), for: .touchDown)
            return cell
        }else{
            let imgprof = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.socialAvatar as! NSString
            let indexProf = imgprof.integerValue as! Int
            cell.improf?.image = SingletonServer.singleton.logoImage[topic]
            cell.backView?.backgroundColor = SingletonServer.singleton.colori[topic]
            cell.backView?.layer.cornerRadius = 32.0
            cell.descrizione?.text = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].description
            cell.descrizione?.textColor = .white
            cell.nickname?.text = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.nickname
            cell.nickname?.textColor = .white
            cell.nickname?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.numero?.layer.cornerRadius = 12.0
            cell.numero?.clipsToBounds = true
//            cell.numero?.text = "\(String(describing: SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].answers?.count))"
            cell.numero?.backgroundColor = .white
            cell.numero?.textColor = SingletonServer.singleton.colori[topic]
            cell.numero?.textAlignment = .center
            cell.data?.text =  SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].endDate
            cell.data?.textColor = .white
            
            cell.backView?.addTarget(self, action: #selector(performeQuest), for: .touchDown)
            
        }
        return cell
    }
        
//        //        var questCount = (SingletonServer.singleton.events_questions_aroundPosition?.questions?.count)!
//        var questCount = 0
//        if(SingletonServer.singleton.events_questions_aroundPosition?.questions != nil){
//            questCount = (SingletonServer.singleton.events_questions_aroundPosition?.questions?.count)!
//
//        }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PulleyTableViewCell
//
//        let color = SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row].topic!
//        let indexTopic = Int(color!)
//        let imgprof = SingletonServer.singleton.user?.socialAvatar as! NSString
//        let indexProf = imgprof.integerValue as! Int
//
//        if indexPath.row < questCount {
//            cell.improf?.image = SingletonServer.singleton.logoImage[indexProf]
//            cell.backView?.backgroundColor = SingletonServer.singleton.colori[indexTopic]
//            cell.backView?.layer.cornerRadius = 32.0
//            cell.descrizione?.text = SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row].name
//            cell.descrizione?.textColor = .white
//            cell.title?.text = SingletonServer.singleton.user?.nickname
//            cell.title?.textColor = .white
//            cell.title?.font = UIFont.boldSystemFont(ofSize: 16.0)
//            cell.numMessages?.layer.cornerRadius = 12.0
//            cell.numMessages?.clipsToBounds = true
//            cell.numMessages?.text = "\(String(describing: SingletonServer.singleton.domande?.answers?.count))"
//            cell.numMessages?.backgroundColor = .white
//            cell.numMessages?.textColor = SingletonServer.singleton.colori[indexTopic]
//            cell.numMessages?.textAlignment = .center
//            cell.date?.text =  SingletonServer.singleton.domande?.dateFine
//            cell.date?.textColor = .white
//
//            cell.backView?.addTarget(self, action: #selector(performeQuest), for: .touchDown)
//
//        }
//        else {
//            //            cell.improf?.image = SingletonServer.singleton.events_questions_aroundPosition?.events[indexPath.row - questCount]
//            print("\(String(describing: SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row - questCount].datetime)) - \(String(describing: SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row - questCount].endDate))")
//            cell.date?.text = "\(String(describing: SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row - questCount].datetime)) - \(String(describing: SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row - questCount].endDate))"
//            cell.date?.textColor = .black
//            cell.numMessages?.text = "\(String(describing: SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row - questCount].answers?.count))"
//            cell.numMessages?.textColor = .white
//            cell.numMessages?.backgroundColor = .black
//            cell.numMessages?.textAlignment = .center
//            cell.numMessages?.layer.cornerRadius = 12.0
//            cell.numMessages?.clipsToBounds = true
//            cell.descrizione?.text = SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row - questCount].description
//            cell.descrizione?.textColor = .black
//            cell.title?.text = SingletonServer.singleton.events_questions_aroundPosition?.events![indexPath.row - questCount].name
//            cell.title?.textColor = .black
//            cell.backView?.layer.borderWidth = 1
//            cell.backView?.layer.borderColor = UIColor(red: 0/255, green: 90/255, blue: 50/255, alpha: 1.0).cgColor
//            cell.backView?.layer.cornerRadius = 32.0
//
//            //            cell.backView?.addTarget(self, action: #selector(performeEvent), for: .touchDown)
//
//        }
//
//        return cell
        
    
    
    @objc func performeQuest(){
        self.performSegue(withIdentifier: "seguePulleyMessage", sender: nil)
        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
    
    @objc func performeEvent(){
        self.performSegue(withIdentifier: "seguePulleyEvent", sender: nil)
        self.pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
    }
    
 
    
    func createNewQuestion(){
        self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        let user = SingletonServer.singleton.retrieveUserState()
        let radar = SingletonServer.singleton.user?.posFit
        let data = dateFromTimeout(timeout: 3)
        let topic = SingletonServer.singleton.chosenTopic
        SingletonServer.singleton.chosenTopic = 0
        SingletonServer.singleton.POST_insertNewQuestion(text: AskQuestionTextField.text!, dateFine: data, userOwner: user, radar: radar!, topic: Int32(topic)) { (result) in
            let decoder = JSONDecoder()
            let da = result?.data(using: .utf8)
            do{
                let question = try decoder.decode(DBQuestion.self, from: da!)
                if(question.ID != nil){
                    
                    
//                    SingletonServer.singleton.user?.myQuestions?.append(question)
//                    SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
                    
                    
                    SingletonServer.singleton.user?.myQuestions?.append(question)
                    SingletonServer.singleton.domandeOrdinatePerTopic[Int(question.topic!)].append(question)
                    
                    print(question.text!)
                }
            }catch{
                print("errore di serializzazione|LATOCLIENT")
            }
            
            
        }
    }
    
    
    
}




