//
//  ChatViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Chat1TableViewCell
        
        if indexPath.row == 0{
            cell.improf.image = #imageLiteral(resourceName: "Lorenzo")
            cell.sfondo.backgroundColor = .red
            cell.desc.text = "Andiamo a ballare? Waju o drag"
            cell.desc.textColor = .white
            cell.nickname.text = "Lorenzo"
            cell.nickname.textColor = .white
            cell.num.layer.cornerRadius = 12.0
            cell.num.clipsToBounds = true
            cell.num.text = "2"
            cell.num.backgroundColor = .white
            cell.num.textColor = .red
            cell.num.textAlignment = .center
            cell.inizio.text = "22:00"
            cell.inizio.textColor = .white
            
            
            
            return cell
    }else{
    cell1.improf1.image = #imageLiteral(resourceName: "Giorgio")
    cell1.inizio1.text = "22:00"
    cell1.inizio1.textColor = .black
    cell1.num1.text = "14"
    cell1.num1.textColor = .white
    cell1.num1.backgroundColor = .black
    cell1.num1.textAlignment = .center
    cell1.num1.layer.cornerRadius = 12.0
    cell1.num1.clipsToBounds = true
    cell1.desc1.text = "O DRAGGGGGGGGGGGGGGGGGGGGGGGG"
    cell1.desc1.textColor = .black
    cell1.nick1.text = "Giorgia"
    cell1.nick1.textColor = .black
    cell1.divisore.text = "-"
    cell1.divisore.textColor = .black
    cell1.sfondo1.layer.borderWidth = 1
    cell1.fine.text = "2:00"
    cell1.fine.textColor = .black
    cell1.sfondo1.layer.borderColor = UIColor(red: 0/255, green: 90/255, blue: 50/255, alpha: 1.0).cgColor
    return cell1
    }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        var titolo = ""
        title?.append(titolo)
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
