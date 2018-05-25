//
//  PuViewController.swift
//  ProvaPulley
//
//  Created by Lorenzo Caso on 22/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import Pulley



class DrawerContentViewController: UIViewController{

    @IBOutlet weak var cerca2: UITextField!
    @IBOutlet weak var Pu: UIView!
    @IBOutlet weak var table: UITableView!
    
    var topicBool: [Bool] = [false, false, false, false, false, false, false]
    
    @IBOutlet weak var anyy: UICustomButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Pu.layer.cornerRadius = 5.0
        Pu.clipsToBounds = true
        
//        cerca2.clearButtonMode = .always
        self.hideKeyboardWhenTappedAround()
        
        //        cerca.layer.borderWidth = 1
        //        cerca.layer.borderColor = UIColor(red: 255/255, green: 253/255, blue: 247/255, alpha: 1.0).cgColor
        //
    
        
    }

    @IBAction func cerca(_ sender: Any) {
        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
        
        
    }
    
    
    @IBAction func Cancel(_ sender: Any) {
        dismissKeyboard()
    self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        
    }
    
    @IBAction func anyy1(_ sender: Any) {
        if topicBool[0] == false {
            anyy.backgroundColor = UIColor.blue
            let myColor = UIColor.white
            anyy.layer.borderColor = myColor.cgColor
            anyy.setTitleColor(UIColor.white, for: UIControlState.normal)
            topicBool[0] = true
        }
        else {
            anyy.backgroundColor = UIColor.white
            let myColor = UIColor.black
            anyy.layer.borderColor = myColor.cgColor
            anyy.setTitleColor(UIColor.black, for: UIControlState.normal)
            topicBool[0] = false
        }
        
        

      
        
       
    }
    
    
 
  
}




