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
    
    
    @IBOutlet weak var table1: UITableView!
    
    @IBOutlet weak var table2: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.table1{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table1.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cella1SettingsTableViewCell
        
        let cell1 = table1.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Cella2SettingsTableViewCell
        
        let cell2 = table2.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! Cella3SettiongsTableViewCell
        
        if tableView == self.table1{
            if indexPath.row == 0{
        cell.notifiche.image = #imageLiteral(resourceName: "notifica")
        cell.scritta.text = "Notifications"
        return cell
        }else{
            cell1.scritta.text = "Report a problem"
           cell1.imm.image = #imageLiteral(resourceName: "warning")
            return cell1
        }
        }
        
        if tableView == self.table2{
            
            cell2.scritta.text = "City"
            cell2.imm.image = #imageLiteral(resourceName: "position")
            return cell2
        }else{
            return cell2
        }

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
