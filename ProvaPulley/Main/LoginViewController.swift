//
//  LoginViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 05/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var nick: UITextField!
    @IBOutlet weak var logi: UIButton!
    @IBOutlet weak var facebook: UIButton!
    
    
    
    @IBAction func Log(_ sender: Any) {
        print("CIAO")
        SingletonServer.singleton.POST_log(email: nick.text!, password: password.text!) { (result) in
            do{
            let jsonString = result!
            let data: Data? = jsonString.data(using: .utf8)
            let decoder = JSONDecoder()
            let user = try decoder.decode(DBUser.self, from: data!)
            print("OMI2")
            if user.email != nil{
                        SingletonServer.singleton.saveUserState(json: jsonString, user: user)

                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "perfse"), object: nil)
                        }
                }
                
                
            }catch{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: result, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }


           
            
        }
        
        
    }
    

    
 
    @IBOutlet weak var imm: UIImageView!
    
    @IBOutlet var vista: UIView!
    
    override func viewDidAppear(_ animated: Bool) {

        let user =  SingletonServer.singleton.retrieveUserState()
        if(user.email != nil){
            loadHomeScreen()
        }

        }
        
    override func viewWillAppear(_ animated: Bool){
        
        
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
        
        password.delegate = self as! UITextFieldDelegate
        nick.delegate = self as! UITextFieldDelegate
        
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
        
        
        
        setupTable()
    }
    @objc func performa() {
        self.performSegue(withIdentifier: "seguelogin", sender: self)
    }
    
    func setupTable() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(performa), name: NSNotification.Name(rawValue: "perfse"), object: nil)
        
        
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
