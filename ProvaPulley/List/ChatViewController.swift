//
//  ChatViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
//        let user = SingletonServer.singleton.retrieveUser()
//        if(user.email != nil){
//            updateMyQuestions_MyEventsWithCorrispectiveAnswers(email: user.email!)
//        }
        self.tableview.reloadData()
    }
    
//    func updateMyQuestions_MyEventsWithCorrispectiveAnswers(email:String){
//        SingletonServer.singleton.MyQuestions_Events(email: email) { (result) in
//
//            do{
//                let jsonString = result!
//                let data: Data? = jsonString.data(using: .utf8)
//                let dec = JSONDecoder()
//                let user  = try  dec.decode(DBUser.self, from: data!)
//                if(user.email != nil){
//                    SingletonServer.singleton.saveUserState(json: jsonString, user: user)
//                }
//
//
//
//
//
//            }catch{
//                print("ERRORE di serializzazione")
//            }
//        }
//    }
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(SingletonServer.singleton.user?.myQuestions != nil){
            return (SingletonServer.singleton.user?.myQuestions?.count)!
            }else{
            return 0
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Chat1TableViewCell
        let imgprof = SingletonServer.singleton.user?.socialAvatar as! NSString
        let indexProf = imgprof.integerValue as! Int
        
        let color = SingletonServer.singleton.user?.myQuestions![indexPath.row].topic 
        let indexTopic = Int(color!)
        
        
        
        
        
            //        if indexPath.row == 0{
            cell.improf.image = SingletonServer.singleton.logoImage[indexProf]
            cell.sfondo.backgroundColor = SingletonServer.singleton.colori[indexTopic]
            cell.desc.text = SingletonServer.singleton.user?.myQuestions![indexPath.row].text
            cell.desc.textColor = .white
            cell.nickname.text = SingletonServer.singleton.user?.nickname
            cell.nickname.textColor = .white
            cell.num.layer.cornerRadius = 12.0
            cell.num.clipsToBounds = true
            cell.num.text = "\(SingletonServer.singleton.user?.myQuestions![indexPath.row].dateFine)"
            cell.num.backgroundColor = .white
            cell.num.textColor = SingletonServer.singleton.colori[indexTopic]
            cell.num.textAlignment = .center
            cell.inizio.text = "\(SingletonServer.singleton.user?.myQuestions![indexPath.row].answers?.count)"
            cell.inizio.textColor = .white
        
        
            
            
            return cell
            
            
//            }else{
//            cell1.improf1.image = #imageLiteral(resourceName: "Giorgio")
//            cell1.inizio1.text = "22:00"
//            cell1.inizio1.textColor = .black
//            cell1.num1.text = "14"
//            cell1.num1.textColor = .white
//            cell1.num1.backgroundColor = .black
//            cell1.num1.textAlignment = .center
//            cell1.num1.layer.cornerRadius = 12.0
//            cell1.num1.clipsToBounds = true
//            cell1.desc1.text = "O DRAGGGGGGGGGGGGGGGGGGGGGGGG"
//            cell1.desc1.textColor = .black
//            cell1.nick1.text = "Giorgia"
//            cell1.nick1.textColor = .black
//            cell1.divisore.text = "-"
//            cell1.divisore.textColor = .black
//            cell1.sfondo1.layer.borderWidth = 1
//            cell1.fine.text = "2:00"
//            cell1.fine.textColor = .black
//            cell1.sfondo1.layer.borderColor = UIColor(red: 0/255, green: 90/255, blue: 50/255, alpha: 1.0).cgColor
//            return cell1
//            }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print("ciiii")
//        DataManager.shared.sfondoColor = Int((SingletonServer.singleton.user?.myQuestions![indexPath.row].topic!)!)
//        print("CIIII\(DataManager.shared.sfondoColor)")
  
    }
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
 
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
