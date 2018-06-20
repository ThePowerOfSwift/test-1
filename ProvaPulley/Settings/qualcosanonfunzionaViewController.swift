//
//  qualcosanonfunzionaViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 19/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class qualcosanonfunzionaViewController: UIViewController {

    @IBOutlet weak var limite: UIView!
    @IBAction func send(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancel(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Settings", bundle: nil) //declare the storyboard
//        let profile = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
//        self.present(profile, animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        hideKeyboardWhenTappedAround()
        limite.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 231/255.0, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
