//
//  NotificheViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 04/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class NotificheViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBOutlet weak var tabella: UITableView!
    @IBOutlet weak var messaggio: UILabel!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellaNotificheTableViewCell
        
        cell.scritta.text = "Enable all notifications"
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        messaggio.text = "Se disattiverai tutte le notifiche, l'applicazione sarà inutile"
       
        self.title = "Notifications"
        
        messaggio.textColor = UIColor.lightGray
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
