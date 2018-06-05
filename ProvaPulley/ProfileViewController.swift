//
//  ProfileViewController.swift
//  
//
//  Created by Sofia Passarelli on 30/05/18.
//  BatChat
//
//  Created by Lorenzo Caso on 30/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func Signout(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "Are you sure that you want to exit?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBOutlet weak var table1: UITableView!
    
    @IBOutlet weak var table2: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.table1{
            return 2
        }
        if tableView == self.table2{
            
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.table2{
            if indexPath.row == 0{
                let alert = UIAlertController(title: "Report A Problem", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vm = UIView()
        vm.backgroundColor = UIColor.purple
        return vm
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table1.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cella1SettingsTableViewCell
        
        let cell1 = table1.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Cella2SettingsTableViewCell
        
        let cell2 = table2.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! Cella3SettiongsTableViewCell
        let cell3 = table2.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! Cella4SettingsTableViewCell
        
        
        if tableView == self.table1{
            if indexPath.row == 0{
        cell.notifiche.image = #imageLiteral(resourceName: "notifica")
        cell.scritta.text = "Notifications"
        return cell
        }else{
            cell1.scritta.text = "Modify Password"
           cell1.imm.image = #imageLiteral(resourceName: "modify")
            return cell1
        }
        }
        
        if tableView == self.table2{
            if indexPath.row == 0{
            cell2.scritta.text = "Report Problems"
            cell2.imm.image = #imageLiteral(resourceName: "warning")
            return cell2
            }
            if indexPath.row == 1{
                cell3.imm.image = #imageLiteral(resourceName: "privacy")
                cell3.scritta.text = "Privacy Information"
                return cell3
            }
        }
        

        return cell2
    }
    



    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var icon: UIButton!
    
    @IBAction func change(_ sender: Any) {
        
            let img = self.icon.currentBackgroundImage
            let numWorld = DataManager.shared.profile.index(of: img!)!
        
            if numWorld == DataManager.shared.profile.count - 1 {
                self.icon.setBackgroundImage(DataManager.shared.profile[0], for: .normal)
            }
            else {
                self.icon.setBackgroundImage(DataManager.shared.profile[numWorld + 1], for: .normal)
            }
        
    }
    
    @IBAction func prova(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nome.textAlignment = .center
        nome.text = "Antonio Falso"
       
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController?.navigationBar.tintColor = .black

        
        // Do any additional setup after loading the view.
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
