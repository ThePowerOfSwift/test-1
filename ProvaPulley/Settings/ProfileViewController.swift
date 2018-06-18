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
    
    //    fatto da Luca
    
    //    Outlet
    
    var buttonOpen = false
    
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var button6: UIButton!
    
    @IBOutlet weak var button7: UIButton!
    
    @IBOutlet weak var button8: UIButton!
    
    @IBOutlet weak var button9: UIButton!
    
    @IBOutlet weak var signButton: UIBarButtonItem!
    
    
    //     Metodi
    
    @IBAction func avatarButtonFunc(_ sender: Any) {
        //     central button
        
        //         flag
        
        if buttonOpen == false {
            buttonOpen = true
        } else {
            buttonOpen = false
        }
        
        print(buttonOpen)
        
        //       central button animation
        
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        
        

        
        if buttonOpen == true {
            
            
            //          sparisce il nome
            
            UIView.animate(withDuration: 0.2, delay: 0.0,options: [],
                           
                           animations: { self.nome.alpha = 0 })
            
            //          button telefono animation
            
            
            UIView.animate(withDuration: 0.5, delay: 0.1,options: [],
                           
                           animations: { self.button1.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.3,options: [],
                           
                           animations: { self.button2.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.5,options: [],
                           
                           animations: { self.button3.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.7,options: [],
                           
                           animations: { self.button4.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.9,options: [],
                           
                           animations: { self.button5.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.1,options: [],
                           
                           animations: { self.button6.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.3,options: [],
                           
                           animations: { self.button7.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.5,options: [],
                           
                           animations: { self.button8.alpha = 1 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.7,options: [],
                           
                           animations: { self.button9.alpha = 1 })
            
            
        } else {
            
            
            
            //          riappare nome e tableview
            
            UIView.animate(withDuration: 0.2, delay: 1.9,options: [],
                           
                           animations: { self.nome.alpha = 1 })
            
            //          button telefono animation chiudi
            
            
            UIView.animate(withDuration: 0.5, delay: 0.1,options: [],
                           
                           animations: { self.button1.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.3,options: [],
                           
                           animations: { self.button2.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.5,options: [],
                           
                           animations: { self.button3.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.7,options: [],
                           
                           animations: { self.button4.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 0.9,options: [],
                           
                           animations: { self.button5.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.1,options: [],
                           
                           animations: { self.button6.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.3,options: [],
                           
                           animations: { self.button7.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.5,options: [],
                           
                           animations: { self.button8.alpha = 0 })
            
            
            UIView.animate(withDuration: 0.5, delay: 1.7,options: [],
                           
                           animations: { self.button9.alpha = 0 })
            
            
        }
        
        
        
        
    }
    
    
    @IBAction func button1Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Francesco"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button2Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Antonio vero"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button3Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Sofia"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button4Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Giorgio"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button5Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Hind"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button6Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Antonio falso"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button7Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Luca"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button8Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Lorenzo"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    @IBAction func button9Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Silvia"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
    }
    
    
    
    
    //    Fine /Luca <<<<<<<<<<<<<
    
    @IBAction func Signout(_ sender: Any) {
        
        if SingletonServer.singleton.skipper {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) //declare the storyboard
            let profile = storyboard.instantiateViewController(withIdentifier: "10") //after assigning an id to  LoginViewController in order to be identified, we instanciaite and return a LoginViewController
            self.present(profile, animated: true, completion: nil) //here the LoginViewController is presented
        } else {
            let alert = UIAlertController(title: "", message: "Are you sure that you want to exit?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { (ACTION)
                in
                SingletonServer.singleton.removeUserState()
                let storyboard = UIStoryboard(name: "Main", bundle: nil) //declare the storyboard
                let profile = storyboard.instantiateViewController(withIdentifier: "10") //after assigning an id to  LoginViewController in order to be identified, we instanciaite and return a LoginViewController
                self.present(profile, animated: true, completion: nil) //here the LoginViewController is presented
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
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
        
        vm.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 231/255.0, alpha: 1)
        return vm
    }
    
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table1.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cella1SettingsTableViewCell
        
        let cell1 = table1.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! Cella2SettingsTableViewCell
        
        let cell2 = table2.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! Cella3SettiongsTableViewCell
        let cell3 = table2.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! Cella4SettingsTableViewCell
        
        
        if tableView == self.table1{
            if indexPath.row == 0{
        cell.notifiche.image = #imageLiteral(resourceName: "Notifications")
        cell.scritta.text = "Notifications"
        return cell
        }else{
            cell1.scritta.text = "Modify Password"
           cell1.imm.image = #imageLiteral(resourceName: "key")
            return cell1
        }
        }
        
        if tableView == self.table2{
            if indexPath.row == 0{
            cell2.scritta.text = "Report Problems"
            cell2.imm.image = #imageLiteral(resourceName: "Report problem")
            return cell2
            }
            if indexPath.row == 1{
                cell3.imm.image = #imageLiteral(resourceName: "priva")
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
        
        
        //        luca
        
        button1.alpha = 0
        button2.alpha = 0
        button3.alpha = 0
        button4.alpha = 0
        button5.alpha = 0
        button6.alpha = 0
        button7.alpha = 0
        button8.alpha = 0
        button9.alpha = 0
        
        //        end luca
        
        if SingletonServer.singleton.skipper {
            signButton.title = "Sign in"
            avatarButton.setBackgroundImage(#imageLiteral(resourceName: "anonimo"), for: .normal)
            avatarButton.isEnabled = false
        } else {
            avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[Int((SingletonServer.singleton.user?.socialAvatar)!)!], for: .normal)
        }
        avatarButton.layer.cornerRadius = 35
        avatarButton.clipsToBounds = true
        nome.textAlignment = .center
        nome.text = SingletonServer.singleton.user?.nickname
       
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 8/255.0, green: 124/255.0, blue: 255/255.0, alpha: 1)

        
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
