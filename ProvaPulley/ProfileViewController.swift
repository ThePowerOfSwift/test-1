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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cella1SettingsTableViewCell
        
        cell.notifiche.image = #imageLiteral(resourceName: "notifica")
        cell.scritta.text = "Notifications"
        return cell
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
