//
//  ProfileViewController.swift
//  
//
//  Created by Sofia Passarelli on 30/05/18.
//

import UIKit

class ProfileViewController: UIViewController {


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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
