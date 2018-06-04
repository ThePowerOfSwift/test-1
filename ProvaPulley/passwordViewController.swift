//
//  passwordViewController.swift
//  BatChat
//
//  Created by Sofia Passarelli on 30/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class passwordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellaPasswordTableViewCell
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! Cella2PasswordTableViewCell
        
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! Cella3PasswordTableViewCell
        
        if indexPath.row == 0{
            
        cell.scritta.text = "Old"
            return cell
        }
        if indexPath.row == 1{
            cell2.scritta.text = "New"
            return cell2
        }else{
            cell3.scritta.text = "Verify"
            return cell3
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        self.title = "Password"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func doneTapped(){
        dismissKeyboard()
        _ = navigationController?.popToRootViewController(animated: true)
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
