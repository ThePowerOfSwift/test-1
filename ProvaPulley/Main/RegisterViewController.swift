//
//  RegisterViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 06/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBAction func cancel(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    
    
    //    fatto da Luca
    
    //    Outlet
    
    var buttonOpen = false
    
    @IBOutlet weak var nome: UILabel!
    
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
    
    @IBOutlet weak var buttonAvanti: UIButton!
    
    
    //     Metodi
    
    @IBAction func avatarButtonFunc(_ sender: Any) {
        
        
//        //     central button
//
//        //         flag
//
//        if buttonOpen == false {
//            buttonOpen = true
//        } else {
//            buttonOpen = false
//        }
//
//        print(buttonOpen)
//
//        //       central button animation
//
//        UIView.animate(withDuration: 0.2, delay: 0,options: [],
//                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
//
//
//        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
//                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
//
//
//
//
//
//        if buttonOpen == true {
//
//
//            //          sparisce il nome
//
//            UIView.animate(withDuration: 0.2, delay: 0.0,options: [],
//
//                           animations: { self.nome.alpha = 0 })
//
//            //          button telefono animation
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.1,options: [],
//
//                           animations: { self.button1.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.3,options: [],
//
//                           animations: { self.button2.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.5,options: [],
//
//                           animations: { self.button3.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.7,options: [],
//
//                           animations: { self.button4.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.9,options: [],
//
//                           animations: { self.button5.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.1,options: [],
//
//                           animations: { self.button6.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.3,options: [],
//
//                           animations: { self.button7.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.5,options: [],
//
//                           animations: { self.button8.alpha = 1 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.7,options: [],
//
//                           animations: { self.button9.alpha = 1 })
//
//
//        } else {
//
//
//
//            //          riappare nome e tableview
//
//            UIView.animate(withDuration: 0.2, delay: 1.9,options: [],
//
//                           animations: { self.nome.alpha = 1 })
//
//            //          button telefono animation chiudi
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.1,options: [],
//
//                           animations: { self.button1.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.3,options: [],
//
//                           animations: { self.button2.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.5,options: [],
//
//                           animations: { self.button3.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.7,options: [],
//
//                           animations: { self.button4.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 0.9,options: [],
//
//                           animations: { self.button5.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.1,options: [],
//
//                           animations: { self.button6.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.3,options: [],
//
//                           animations: { self.button7.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.5,options: [],
//
//                           animations: { self.button8.alpha = 0 })
//
//
//            UIView.animate(withDuration: 0.5, delay: 1.7,options: [],
//
//                           animations: { self.button9.alpha = 0 })
//
//
//        }
//
//
//
//
    }
    
    
    @IBAction func button1Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Francesco"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button2Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Antonio vero"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button3Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Sofia"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button4Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Giorgio"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button5Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Hind"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button6Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Antonio falso"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button7Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Luca"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button8Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Lorenzo"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button9Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(#imageLiteral(resourceName: "Silvia"), for: .normal)
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
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
        
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        buttonAvanti.alpha = 0
        button1.alpha = 0
        button2.alpha = 0
        button3.alpha = 0
        button4.alpha = 0
        button5.alpha = 0
        button6.alpha = 0
        button7.alpha = 0
        button8.alpha = 0
        button9.alpha = 0

       
 
        nome.text = ""
       
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Login2")!)
        // Do any additional setup after loading the view.
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

}
