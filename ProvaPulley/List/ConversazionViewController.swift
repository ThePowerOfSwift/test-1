//
//  ConversazionViewController.swift
//  
//
//  Created by Sofia Passarelli on 12/06/18.
//

import UIKit

class ConversazionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messaggi: [(String,Bool)] = [("ciao", true),("sono io", false),("ciao", true),("sono io", false),("ciao", true),("sono io", false),("ciao", true),("sono io", false)]
    
    @IBOutlet weak var textfield: UITextView!
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(_ sender: Any) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messaggi.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messaggio = messaggi[indexPath.row]
        if messaggio.1 {
            let cell = tableview.dequeueReusableCell(withIdentifier: "cellinviato", for: indexPath) as! ConversazionCell
            cell.lblData.text = "\(NSDate())"
            cell.lblMessaggio.text = messaggio.0
            print("inviato")
            return cell
            
        } else {
            let cell = tableview.dequeueReusableCell(withIdentifier: "cellricevuto", for: indexPath) as! ConversazionCell
            cell.lblData.text = "\(NSDate())"
            cell.lblMessaggio.text = messaggio.0
            print("ricevuto")
            return cell
               }
         }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
