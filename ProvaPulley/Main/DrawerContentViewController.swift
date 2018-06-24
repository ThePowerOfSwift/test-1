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



class DrawerContentViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITextFieldDelegate {
    
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
    
    
    
    var vetButtons: [UICustomButton] = []
    var messageTable = UITableView(frame: CGRect(x: 0, y: 120, width: 375, height: 458))
    
    //    var topicBool: [Bool] = [true, false, false, false, false, false, false]
    var tableCount:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vetButtons = [self.AnyButton, self.FoodButton, self.NightLifeButton, self.ArtButton, self.Tourism2Button, self.CityInfoButton, self.TourismButton]
        AskQuestionTextField.layer.cornerRadius = 5.0
        AskQuestionTextField.clipsToBounds = true
        self.Gripper.layer.cornerRadius = 3
        
        //      tableView
        self.messageTable.delegate = self
        
        self.messageTable.dataSource = self
        
        self.messageTable.register(PulleyTableViewCell.self, forCellReuseIdentifier: "cell")
        self.messageTable.separatorStyle = .none
        
        self.view.addSubview(messageTable)
        
        AnyButton.backgroundColor = DataManager.shared.mainColor
        AnyButton.layer.borderColor = UIColor.white.cgColor
        
        AnyButton.setTitleColor(.white, for: .normal)
        
        //      topic buttons
        CityInfoButton.borderColor = UIColor.gray.cgColor
        Tourism2Button.borderColor = UIColor.gray.cgColor
        TourismButton.borderColor = UIColor.gray.cgColor
        ArtButton.borderColor = UIColor.gray.cgColor
        NightLifeButton.borderColor = UIColor.gray.cgColor
        FoodButton.borderColor = UIColor.gray.cgColor
        
        setupTable()
        setupEvent()
        setupPulley()
    }
    
    func setupEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadEvent), name: NSNotification.Name(rawValue: "event"), object: nil)
        print("A2")
        
    }
    
    func setupPulley() {
        NotificationCenter.default.addObserver(self, selector: #selector(pulleyMove(notification:)), name: NSNotification.Name(rawValue: "pulley"), object: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        AskQuestionTextField.text = ""
    }
    
    func setupTable() {
        NotificationCenter.default.addObserver(self, selector: #selector(DrawerContentViewController.reload), name: NSNotification.Name(rawValue: "data"), object: self)
        print("LORENZOOOOOOOO")
    }
    
    @objc func reloadEvent(not: Notification) {
        print("AAAAAAAAAAAAAA")
        
        let event = not.object as! EventAnnotation
        print("EVENTO SELEZIONATO:\(event.name)")
        SingletonServer.singleton.eventoSelezionato = event
        performSegue(withIdentifier: "evpulley", sender: nil)
        
    }
   
    @objc func pulleyMove(notification: NSNotification) {
        print("pulleyMove")
        dismissKeyboard()
    }
    
    @objc func reload(notification: NSNotification) {
        self.messageTable.reloadData()
        print("dismissooooo")
        self.dismissKeyboard()

    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
//        self.allButtonsOff(i: 0)
        
    }
    
    @IBAction func askQuestion(_ sender: Any) {
       
        if SingletonServer.singleton.skipper {
            let signInAlert = UIAlertController(title: "Jump in!", message: "Only registered users can ask something or reply to other users. Do you want to register/sign in?", preferredStyle: UIAlertControllerStyle.alert)

            signInAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil) //declare the storyboard
                let profile = storyboard.instantiateViewController(withIdentifier: "10") //after assigning an id to  LoginViewController in order to be identified, we instanciaite and return a LoginViewController
                self.present(profile, animated: true, completion: nil) //here the LoginViewController is presented
            }))

            signInAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in

            }))

            present(signInAlert, animated: true, completion: nil)
        } else {
            self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
        }
    
    
    }
    func POST_ADDAnswerQ(text:String,questionID:Int32, email:String, completionHandler: @escaping(String?) -> Void){
        let a = DBAnswerQ()
        a.text = text
        
        a.question = DBQuestion()
        a.question?.ID = questionID
        a.userOwner = DBUser()
        a.userOwner?.email = email
        let httpMethod = "POST"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do{
            let data = try encoder.encode(a)
            let string = String(data:data, encoding: .utf8)
            
            let httpBody : String = string!
            
            let textUrl : String = "http://10.20.49.178:8181/Question/Answers/add/"
            let url : URL = URL(string: textUrl)!
            let session : URLSession = URLSession.shared
            
            var urlRequest : URLRequest = URLRequest(url: url)
            urlRequest.httpBody = httpBody.data(using: .utf8)
            urlRequest.httpMethod = httpMethod
            
            
            var s:String?
            session.dataTask(with: urlRequest) {
                data, response, error in
                if error != nil {
                    print(error?.localizedDescription)
                    completionHandler(error?.localizedDescription)
                } else {
                    s = String(data: data!, encoding: .utf8)!
                    completionHandler(s)
                }
                }.resume()
            
        }catch{
            print("errore di serializzazione")
        }
        
        
        
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
//        sender animazione quando si manda un messaggio
      
        
        if !SingletonServer.singleton.skipper || self.AskQuestionTextField.text != "" {
            dismissKeyboard()

            let user = SingletonServer.singleton.user
            var radar:DBRadar = (SingletonServer.singleton.user?.posReal)!
            if  let r = SingletonServer.singleton.user?.posFit {
                radar = r
            }
            let data = dateFromTimeout(timeout: 3)
            print(data)
            self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
            SingletonServer.singleton.POST_insertNewQuestion(text: AskQuestionTextField.text!, dateFine: data, userOwner: user!, radar: radar, topic: Int32(SingletonServer.singleton.chosenTopic)) { (result) in
                let decoder = JSONDecoder()
                let da = result?.data(using: .utf8)
                do{
                    let question = try decoder.decode(DBQuestion.self, from: da!)
                    if(question.ID != 0){

                        DispatchQueue.main.async {
                            SingletonServer.singleton.user?.myQuestions?.append(question)
                            SingletonServer.singleton.domandeOrdinatePerTopic[Int(question.topic!)].append(question)
                            SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
                            self.messageTable.reloadData()
                            //
                            print(question.text!)

                        }
                        
                    }
                }catch{
                    print("errore di serializzazione|LATOCLIENT")

                }
            }
        }
        textFieldDidEndEditing(AskQuestionTextField)

        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        Cancel((Any).self)
        return false
    }
    
    @IBAction func anyButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 0
        self.messageTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
        
        self.allButtonsOff(i: 0)
        
        coloroOn(topicNum: 0)
        
    }
    
    @IBAction func foodButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 1
        
        self.messageTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
        self.allButtonsOff(i: 1)
        coloroOn(topicNum: 1)
    }
    
    @IBAction func nightlifeButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 2
        self.messageTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
        self.allButtonsOff(i: 2)
        coloroOn(topicNum: 2)
    }
    
    @IBAction func artButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 3
        self.messageTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
        self.allButtonsOff(i: 3)
        coloroOn(topicNum: 3)
    }
    
    @IBAction func Tourism2Tap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 6
        self.messageTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
        self.allButtonsOff(i: 4)
        coloroOn(topicNum: 4)
    }
    
    
    @IBAction func cityinfoButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 5
        self.messageTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
        self.allButtonsOff(i: 5)
        coloroOn(topicNum: 5)
    }
    
    
    @IBAction func tourismButtonTap(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 4
        self.messageTable.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
        self.allButtonsOff(i: 6)
        coloroOn(topicNum: 6)
    }
    
    
}
extension DrawerContentViewController {
    private func coloroOn( topicNum: Int) {
        
        switch topicNum {
        case 0:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.mainColor}))
        case 1:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.foodColor}))
        case 2:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.nightlifeColor}))
        case 3:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.artColor}))
        case 4:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.tourismColor}))
        case 5:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.cityInfoColor}))
        case 6:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.shopsColor}))
        default:
            print("")
        }
        
        //            UIView.animate(withDuration: 0.3,
        //
        //                           animations: ({button.backgroundColor = UIColor.blue}))
        
        UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].layer.borderColor = UIColor.white.cgColor}))
        
        UIView.animate(withDuration: 0.3, animations:  ({self.vetButtons[topicNum].setTitleColor(UIColor.white, for: UIControlState.normal)}))
        
        //        button.backgroundColor = UIColor.blue
        //        button.layer.borderColor = UIColor.white.cgColor
        //        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        
    }
    /*
     se è un evento colori solo il bordo if-- switch
     se è una chat coloro tutto
     */
    
    private func buttonOff(i: Int) {
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({self.vetButtons[i].backgroundColor = UIColor.white}))
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({self.vetButtons[i].layer.borderColor = UIColor.lightGray.cgColor}))
        
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({self.vetButtons[i].setTitleColor(UIColor.gray, for: UIControlState.normal)}))
        
        //        button.backgroundColor = UIColor.white
        //        button.layer.borderColor = UIColor.black.cgColor
        //        button.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    private func allButtonsOff(i:Int) {
        for cont in 0...6{
            if(cont != i){
                buttonOff(i: cont)
            }
        }
        
    }
    
    
}


extension DrawerContentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.topic = SingletonServer.singleton.chosenTopic
        let count = switchTopic(topic: topic)
        return count
    }
    
    func switchTopic(topic:Int)->Int{
        var count = 0
        
        count = (SingletonServer.singleton.eventiOrdinatiPerTopic[topic].count)
        
        count = count+(SingletonServer.singleton.domandeOrdinatePerTopic[topic].count)
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PulleyTableViewCell
        tableView.isScrollEnabled = true
        
        let questNum = SingletonServer.singleton.domandeOrdinatePerTopic[topic].count
        
        if indexPath.row < questNum{
//            print("cazzo!")
            let imgprof = SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.socialAvatar as! NSString
            let indexProf = imgprof.integerValue
            cell.improf?.image = SingletonServer.singleton.logoImage[indexProf]
            cell.backView?.backgroundColor = SingletonServer.singleton.coloroOn(topicNum: topic)
            cell.backView?.layer.cornerRadius = 32.0
            cell.backView?.layer.borderWidth = 1
            cell.backView?.layer.borderColor = SingletonServer.singleton.coloroOn(topicNum: topic).cgColor
            cell.descrizione?.text =               SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].text
            cell.descrizione?.textColor = .white
            cell.nickname?.text = SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.nickname
            cell.nickname?.textColor = .white
            cell.nickname?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.numero?.layer.cornerRadius = 12.0
            cell.numero?.clipsToBounds = true
            if let _ = SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].answers?.count {
                cell.numero?.text = "\(String(describing: SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].answers?.count))"
                } else {
                    cell.numero?.text = "0"
                }
            cell.numero?.backgroundColor = .white
            cell.numero?.textColor = SingletonServer.singleton.coloroOn(topicNum: topic)
            cell.numero?.textAlignment = .center
            
            cell.dataEvent?.isHidden = true
            cell.data?.isHidden = false
            let dataFormat: String = String(String(SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].dateFine!.dropFirst(11)).dropLast(3))
            
            print("ORARIO VEDI QUI \(dataFormat)")
    
            cell.data?.text = dataFormat
            cell.data?.textColor = .white
            
            cell.backView?.addTarget(self, action: #selector(performeQuest), for: .touchDown)
            return cell
        }
        else {
//            let imgprof = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.socialAvatar! as! NSString
//            _ = imgprof.integerValue as! Int
//                        cell.improf?.image = SingletonServer.singleton.logoImage[topic]
            let imgprof = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].ownerUser?.socialAvatar as! NSString
            let indexProf = imgprof.integerValue
            cell.improf?.image = SingletonServer.singleton.logoImage[indexProf]
            cell.backView?.backgroundColor = UIColor.white
            cell.backView?.layer.cornerRadius = 32.0
            cell.backView?.layer.borderWidth = 1
            cell.backView?.layer.borderColor = SingletonServer.singleton.coloroOn(topicNum: topic).cgColor
            cell.descrizione?.text = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].description
            cell.descrizione?.textColor = .black
            cell.nickname?.text = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].ownerUser?.nickname
            cell.nickname?.textColor = .black
            cell.nickname?.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.numero?.layer.cornerRadius = 12.0
            cell.numero?.clipsToBounds = true
            
            if let _ = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].answers?.count {
                cell.numero?.text = "\(String(describing: SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].answers?.count))"
            } else {
                cell.numero?.text = "0"
            }
//                        cell.numero?.text = "\(String(describing: SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].answers?.count))"
            cell.numero?.backgroundColor = SingletonServer.singleton.coloroOn(topicNum: topic)
            cell.numero?.textColor = .white
            cell.numero?.textAlignment = .center
            
            cell.dataEvent?.isHidden = false
            cell.data?.isHidden = true
            
             let dataInitFormat: String = String(String(SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].datetime!.dropFirst(11)).dropLast(3))
            
            let dataEndFormat: String = String(String(SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].endDate!.dropFirst(11)).dropLast(3))
            
            cell.dataEvent?.text =  "\(dataInitFormat) - \(dataEndFormat)"
            cell.dataEvent?.textColor = .black
            
            cell.backView?.addTarget(self, action: #selector(performeQuest), for: .touchDown)
            
        }
        return cell
    }
    
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
        var radar:DBRadar = (SingletonServer.singleton.user?.posReal)!
        if let r = SingletonServer.singleton.user?.posFit{
            radar = (SingletonServer.singleton.user?.posFit)!
        }
        let data = dateFromTimeout(timeout: 3)
        let topic = SingletonServer.singleton.chosenTopic
        SingletonServer.singleton.chosenTopic = 0
        
        SingletonServer.singleton.POST_insertNewQuestion(text: AskQuestionTextField.text!, dateFine: data, userOwner: user, radar: radar, topic: Int32(topic)) { (result) in
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




