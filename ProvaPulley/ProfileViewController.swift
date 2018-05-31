//
//  ProfileViewController.swift
<<<<<<< HEAD
//  
//
//  Created by Sofia Passarelli on 30/05/18.
=======
//  BatChat
//
//  Created by Lorenzo Caso on 30/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
>>>>>>> 26daeed12b9f9677619c9641e8c15041c1f433b2
//

import UIKit

class ProfileViewController: UIViewController {

<<<<<<< HEAD

    @IBOutlet weak var icon: UIButton!
    
    @IBAction func change(_ sender: Any) {
        
            let img = self.icon.currentBackgroundImage
            let numWorld = DataManager.shared.profile.index(of: img!)!
        
            if numWorld == DataManager.shared.profile.count - 1 {
                self.icon.setBackgroundImage(DataManager.shared.profile[0], for: .normal)
            }
            else {
                self.icon.setBackgroundImage(DataManager.shared.profile[numWorld + 1], for: .normal)
            }
        
    }
    
=======
    @IBAction func prova(_ sender: Any) {
    }
>>>>>>> 26daeed12b9f9677619c9641e8c15041c1f433b2
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
<<<<<<< HEAD
 
    
=======

>>>>>>> 26daeed12b9f9677619c9641e8c15041c1f433b2
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
