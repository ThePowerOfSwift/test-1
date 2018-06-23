//
//  ChatViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIViewControllerPreviewingDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    var topic = 0
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
        let questNum = SingletonServer.singleton.domandeOrdinatePerTopic[topic].count
        let color = SingletonServer.singleton.user?.myQuestions![indexPath.row].topic 
        let indexTopic = Int(color!)
        
        
        
        
        
                    if indexPath.row == 0{
                        let imgprof = SingletonServer.singleton.domandeOrdinatePerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.socialAvatar as! NSString
                        let indexProf = imgprof.integerValue
                        cell.improf?.image = SingletonServer.singleton.logoImage[indexProf]
            
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
            cell.questionSelezionata = QSelezionata(id: (SingletonServer.singleton.user?.myQuestions![indexPath.row].ID)!, index: indexPath.row)

            return cell
            
            
    }else{
                        
                        let imgprof = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row].ownerUser?.socialAvatar as! NSString
                        let indexProf = imgprof.integerValue
                        cell.improf?.image = SingletonServer.singleton.logoImage[indexProf]
                        cell1.sfondo1.backgroundColor = UIColor.white
                        cell1.sfondo1?.layer.cornerRadius = 32.0
                        cell1.sfondo1?.layer.borderWidth = 1
                        cell1.sfondo1.layer.borderColor = SingletonServer.singleton.coloroOn(topicNum: topic).cgColor
                        cell1.desc1.text = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].description
                        cell1.desc1.textColor = .black
                        cell1.nick1.text = SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].ownerUser?.nickname
                        cell1.nick1.textColor = .black
                        cell1.nick1.font = UIFont.boldSystemFont(ofSize: 16.0)
                        cell1.num1.layer.cornerRadius = 12.0
                        cell1.num1.clipsToBounds = true
                        //                        cell.numero?.text = "\(String(describing: SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].answers?.count))"
                        cell1.num1.backgroundColor = SingletonServer.singleton.coloroOn(topicNum: topic)
                        cell1.num1.textColor = .white
                        cell1.num1.textAlignment = .center
                        
//                        cell.dataEvent?.isHidden = false
//                        cell.data?.isHidden = true
                        
                        let dataInitFormat: String = String(String(SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].datetime!.dropFirst(11)).dropLast(3))
                        
                        let dataEndFormat: String = String(String(SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic][indexPath.row - questNum].endDate!.dropFirst(11)).dropLast(3))
                        
                        cell1.inizio1.text =  "\(dataInitFormat) - \(dataEndFormat)"
                        cell1.inizio1.textColor = .black
                        
                       

            return cell1
            }
    
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print("ciiii")
//        DataManager.shared.sfondoColor = Int((SingletonServer.singleton.user?.myQuestions![indexPath.row].topic!)!)
//        print("CIIII\(DataManager.shared.sfondoColor)")
  
    }
    
   
    func detailViewController(for index: Int) -> DentroLaChatViewController {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "dentro") as? DentroLaChatViewController else {
            fatalError("Couldn't load detail view controller")
        }
        
       
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableview.indexPathForRow(at: location) {
            previewingContext.sourceRect = tableview.rectForRow(at: indexPath)
            return detailViewController(for: indexPath.row)
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = detailViewController(for: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForPreviewing(with: self, sourceView: tableview)
 
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
