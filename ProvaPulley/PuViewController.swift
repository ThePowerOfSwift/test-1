//
//  PuViewController.swift
//  ProvaPulley
//
//  Created by Lorenzo Caso on 22/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import Pulley



class PuViewController: UIViewController, UITextFieldDelegate, PulleyDrawerViewControllerDelegate, UITableViewDelegate{

   
   
    @IBAction func cerca(_ sender: Any) {
        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
        
        
    }
    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func Cancel(_ sender: Any) {
        dismissKeyboard()
    self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        
    }
    

    @IBOutlet weak var cerca2: UITextField!
    
    
    @IBOutlet weak var Pu: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Pu.layer.cornerRadius = 5.0
        Pu.clipsToBounds = true
        
        cerca2.clearButtonMode = .always
        self.hideKeyboardWhenTappedAround()
        
        if self.pulleyViewController?.drawerPosition != PulleyPosition.open {
            dismissKeyboard()
        }
//        cerca.layer.borderWidth = 1
//        cerca.layer.borderColor = UIColor(red: 255/255, green: 253/255, blue: 247/255, alpha: 1.0).cgColor
//        
       
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.pulleyViewController?.setNeedsSupportedDrawerPositionsUpdate() 
        if self.pulleyViewController?.drawerPosition != PulleyPosition.open {
            dismissKeyboard()
        }
    }
    
    
    
    
  
}

public extension UIViewController {
    
    /// If this viewController pertences to a PulleyViewController, return it.
    public var pulleyViewController: PulleyViewController? {
        var parentVC = parent
        while parentVC != nil {
            if let pulleyViewController = parentVC as? PulleyViewController {
                return pulleyViewController
            }
            parentVC = parentVC?.parent
        }
        return nil
    }
    
}



