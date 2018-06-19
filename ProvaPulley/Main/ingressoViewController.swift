//
//  ingressoViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 19/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ingressoViewController: UIViewController {

    @IBOutlet var vista: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.vista.backgroundColor = UIColor(patternImage: UIImage(named: "ingresso")!)
        // Do any additional setup after loading the view.
        
        
       
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    func pushTo(viewController: ViewControllerType)  {
        sleep(3)
        switch viewController {
        case .autenticazione:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "10") as! LoginViewController
            self.present(vc, animated: false, completion: nil)
        case .entro:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoggedInViewController") as! SelectedViewController
            self.present(vc, animated: false, completion: nil)
        }
}
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if let userInformation = UserDefaults.standard.dictionary(forKey: "userInformation") {
//            let email = userInformation["email"] as! String
//            let password = userInformation["password"] as! String
//            SingletonServer.singleton.user?.email
//            User.loginUser(withEmail: email, password: password, completion: { [weak weakSelf = self](status) in
//                DispatchQueue.main.async {
        let user =  SingletonServer.singleton.retrieveUserState()
        if(user.email != nil){
                       pushTo(viewController: .entro)
                    } else {
                        pushTo(viewController: .autenticazione)
                    }
    }
}
