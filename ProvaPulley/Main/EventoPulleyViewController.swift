//
//  EventoPulleyViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 18/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class EventoPulleyViewController: UIViewController {
    @IBAction func Cancel(_ sender: Any) {

        navigationController?.popToRootViewController(animated: true)
        self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var grip: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backBarButtonItem?.title = "Back"
       

        self.grip.layer.cornerRadius = 3
        grip.clipsToBounds = true
        self.pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
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
