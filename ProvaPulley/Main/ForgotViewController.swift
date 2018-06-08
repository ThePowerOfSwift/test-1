//
//  ForgotViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 06/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController {

    @IBOutlet weak var fatto: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBAction func annulla(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        fatto.layer.cornerRadius = 13.0
        fatto.clipsToBounds = true
        
        cancel.layer.cornerRadius = 13.0
        cancel.clipsToBounds = true
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
