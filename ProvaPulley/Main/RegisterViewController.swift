

import UIKit

class RegisterViewController: UIViewController {
    var imgScelta:Int?
    
    @IBOutlet weak var annull: UIButton!
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
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[0], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "0"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button2Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[1], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "1"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button3Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[2], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "2"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button4Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[3], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "3"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button5Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[4], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "4"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button6Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[5], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "5"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button7Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[6], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "6"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button8Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[7], for: .normal)
        
        SingletonServer.singleton.user?.socialAvatar = "7"
        UIView.animate(withDuration: 0.2, delay: 0,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)},completion: nil)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.15,options: [],
                       animations: { self.avatarButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)},completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.1,options: [],
                       
                       animations: { self.buttonAvanti.alpha = 1 })
    }
    
    @IBAction func button9Func(_ sender: Any) {
        self.avatarButton.setBackgroundImage(SingletonServer.singleton.logoImage[8], for: .normal)
        SingletonServer.singleton.user?.socialAvatar = "8"
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
        
        SingletonServer.singleton.user = DBUser()
        
        navigationController?.isNavigationBarHidden = true
        buttonAvanti.layer.cornerRadius = 13.0
        buttonAvanti.clipsToBounds = true
        
        annull.layer.cornerRadius = 13.0
        annull.clipsToBounds = true
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(getimg), name: NSNotification.Name(rawValue: "getimg"), object: nil)
        
    }
    
    @objc func getimg()->Int{
        return imgScelta!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
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
