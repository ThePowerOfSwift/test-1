//
//  EventoPulleyViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 18/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class EventoPulleyViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nomeEvent: UILabel!
    
    @IBOutlet weak var Indirizzo: UILabel!
    
    @IBOutlet weak var startEnd: UILabel!
    
    var Event:EventAnnotation?
    
    
    @IBAction func Cancel(_ sender: Any) {

        navigationController?.popToRootViewController(animated: true)
        self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var grip: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Event = SingletonServer.singleton.eventoSelezionato
        nomeEvent.text = Event?.name
        if(Event?.media?.count != 1){
            let data1 = Data(base64Encoded: (Event?.media)!, options:  .init(rawValue: 1))
            imgView.image = UIImage(data: data1!)
        } else {
            switch (Event?.media!){
            case "1":
                imgView.image = #imageLiteral(resourceName: "food")
            case "2":
                imgView.image = #imageLiteral(resourceName: "nightlife")
            case "3":
                imgView.image = #imageLiteral(resourceName: "art")
            case "4":
                imgView.image = #imageLiteral(resourceName: "Shopping")
            case "5":
                imgView.image = #imageLiteral(resourceName: "cityinfo")
            case "6":
                imgView.image = #imageLiteral(resourceName: "Tourism")
            default: break
            
           
        }
        
        }
        
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

