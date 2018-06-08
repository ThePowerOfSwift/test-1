//
//  LoginViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 05/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var nick: UITextField!
    @IBOutlet weak var logi: UIButton!
    @IBOutlet weak var facebook: UIButton!
    
    @IBAction func Log(_ sender: Any) {
        
        let result = SingletonServer.singleton.login(email: nick.text!, password: password.text!)
        
        //print("ini\(result as! String)fine")
        
        print(result)
        if(result == "Email ok"){

            self.performSegue(withIdentifier: "seguelogin", sender: self)


        }else{
            let alert = UIAlertController(title: "", message: result, preferredStyle: UIAlertControllerStyle.alert)

            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var imm: UIImageView!
    
    @IBOutlet var vista: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = DBUser()
        if currentUser != nil {
            loadHomeScreen()
        }
    }
    func loadHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! SelectedViewController
        self.present(loggedInViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vista.backgroundColor = .white
        
        facebook.backgroundColor = UIColor(red: 65/255.0, green: 103/255.0, blue: 178/255.0, alpha: 1)
        facebook.layer.cornerRadius = 13.0
        facebook.clipsToBounds = true
        
        
        register.layer.cornerRadius = 13.0
        register.clipsToBounds = true
        register.layer.borderWidth = 1
        register.layer.borderColor = UIColor.orange.cgColor
        
        password.layer.cornerRadius = 5.0
        password.clipsToBounds = true
        nick.layer.cornerRadius = 5.0
        nick.clipsToBounds = true
        imm.image = #imageLiteral(resourceName: "login")
        
        logi.layer.cornerRadius = 13.0
        logi.clipsToBounds = true
        
        logi.backgroundColor = .orange
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.vista.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
