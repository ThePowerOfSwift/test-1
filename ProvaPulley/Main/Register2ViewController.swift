//
//  Register2ViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 06/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit


class Register2ViewController: UIViewController {
    var esito:String = ""
    let lenEmail:Int = 45
    let lenNickname = 45
    let lenPassword = 45
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var nickname: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var rPassword: UITextField!
    
    @IBAction func registerFunc(_ sender: Any) {
        
        if((email.text?.count)!>0 && (email.text?.count)!<lenEmail){
            
            if((nickname.text?.count)!>0 && (nickname.text?.count)!<lenNickname){
                
                if((password.text?.count)!>0 && (password.text?.count)!<lenPassword){
                    
                    if(password.text! == rPassword.text!){
                        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
                        let user = DBUser(email: email.text!, nickname: nickname.text!, password: password.text!, socialAvatar:(SingletonServer.singleton.user?.socialAvatar!)! , token: (appDelegate?.returnToken())!)
                        SingletonServer.singleton.provaRegistrazione(user: user) { (result) in
                            if(result == "ok"){
                                print("registrazione effettuata con successo")
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "perfse2"), object: nil)
                                }
                            }else{
                                DispatchQueue.main.async {
                                    let alert = UIAlertController(title: "", message: "Email già esistente", preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                        
                        
                    }else{
                        esito = "La password non corrisponde alla sua ripetizione"
                        
                        let alert = UIAlertController(title: "", message: esito, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }else{
                    esito = "Password di dimensioni scorrette"
                    let alert = UIAlertController(title: "", message: esito, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            }else{
                esito = "Nickname di dimensioni scorrette"
                let alert = UIAlertController(title: "", message: esito, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }else{
            esito = "Email di dimensioni scorrette"
            let alert = UIAlertController(title: "", message: esito, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBOutlet weak var register: UIButton!
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
        
        
        
        
    }
    @IBOutlet weak var indietro: UIButton!
    override func viewDidLoad() {
        
       
        super.viewDidLoad()
        
        indietro.layer.cornerRadius = 13.0
        indietro.clipsToBounds = true
        register.layer.cornerRadius = 13.0
        register.clipsToBounds = true
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Login2")!)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(performa), name: NSNotification.Name(rawValue: "perfse2"), object: nil)
        }
        
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        @objc func performa() {
        self.performSegue(withIdentifier: "segueRegister", sender: self)
        
        }
        
}
