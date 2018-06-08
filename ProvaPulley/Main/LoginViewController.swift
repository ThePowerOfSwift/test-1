//
//  LoginViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 05/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {

    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var nick: UITextField!
    @IBOutlet weak var logi: UIButton!
    @IBOutlet weak var facebook: UIButton!
    let loginButton = FBSDKLoginButton()
    
    
    @IBAction func Log(_ sender: Any) {
        
        SingletonServer.singleton.log(email: nick.text!, password: password.text!) { (result) in
            
            let jsonString = result!
            let data: Data? = jsonString.data(using: .utf8)
            let json = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
            let userRetrieve: DBUser?
            
            
            
            
//            print(json?["email"])
            if(json?["email"] != nil){
                userRetrieve = DBUser(email: json!["email"] as! String, nickname: json!["nickname"] as! String, password: json!["password"] as! String, socialAvatar: json!["socialAvatar"] as! String, token: json!["token"] as! String)
//                print("ATT")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "perfse"), object: nil)
                }
                
                var userDefaults = UserDefaults.standard.set(result, forKey: "user")
                
                

            }else{
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: result, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
        
    }
    
//    @IBAction func Log(_ sender: Any) {
//        let user = DBUser()
//        user.email = nick.text
//        user.nickname = " nicj"
//        user.password = "d dd"
//        user.token = "ddd"
//        UserDefaults.standard.set(user, forKey: "nome")
//
//
//        var userDefaults = UserDefaults.standard
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
//        userDefaults.set(encodedData, forKey: "user")
//        userDefaults.synchronize()
//
//
//        let decoded  = userDefaults.object(forKey: "teams") as! Data
//        let userdec = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! DBUser
//
//
//       let result = SingletonServer.singleton.login(email: nick.text!, password: password.text!)
//
//
//
//       print(userdec.email)
//        if(userdec.email == "giorgio"){
//
//            self.performSegue(withIdentifier: "seguelogin", sender: self)
//
//        }else{
//            let alert = UIAlertController(title: "", message: result, preferredStyle: UIAlertControllerStyle.alert)
//
//            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
 
    @IBOutlet weak var imm: UIImageView!
    
    @IBOutlet var vista: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
//        let currentUser = DBUser()
//        if currentUser.password != nil && currentUser.nickname != nil{
//            loadHomeScreen()
//        }
        let a = UserDefaults.standard.value(forKey: "user")
        if(a != nil){
            let jsonString1 = a as! String
            let data: Data? = jsonString1.data(using: .utf8)
            let json1 = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:AnyObject]
            if(json1?["email"] != nil){
                let userRetrieve1 = DBUser(email: json1!["email"] as! String, nickname: json1!["nickname"] as! String, password: json1!["password"] as! String, socialAvatar: json1!["socialAvatar"] as! String, token: json1!["token"] as! String)
                loadHomeScreen()
            }
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
        
//        facebook.backgroundColor = UIColor(red: 65/255.0, green: 103/255.0, blue: 178/255.0, alpha: 1)
//        facebook.layer.cornerRadius = 13.0
//        facebook.clipsToBounds = true
        
//        Nuovo tasto di facebook integrato nel pod
        
        loginButton.backgroundColor = UIColor(red: 65/255.0, green: 103/255.0, blue: 178/255.0, alpha: 1)
        loginButton.layer.cornerRadius = 13.0
        loginButton.clipsToBounds = true
        loginButton.frame = CGRect(x: 16, y: 514, width: 343, height: 40)
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
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
    
//    funzioni per il login con facebook
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error == nil) {
            print("Utente connesso")
            print("---------------")
            print(result.token.userID)
            print("---------------")
            print(result.token.permissions)
            print("---------------")
            print(result.token.appID)
            print("---------------")
            
        } else
        {
            print(error.localizedDescription)
        }
        
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, age_range, link, gender, locale, timezone, updated_time, verified"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result as Any)
                }
            })
        }
    }
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Utente disconnesso")
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
}
