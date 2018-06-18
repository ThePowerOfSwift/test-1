//
//  SecondaScrollViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 11/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class SecondaScrollViewController: UIViewController {

    var topicBool: [Bool] = [true, false, false, false, false]
    
    
    @IBAction func Taction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 6
        if !topicBool[4] {
            if topicBool[0] {
                topicBool[0] = false
            }
            buttonOn(button: Tourism, topicNum: 6)
            topicBool[4] = true
        }
        else {
            buttonOff(button: Tourism)
            topicBool[4] = false
        }
    }
    
    @IBAction func Saction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 4
        if !topicBool[3] {
            if topicBool[0] {
                topicBool[0] = false
            }
            buttonOn(button: Shops, topicNum: 4)
            topicBool[3] = true
        }
        else {
            buttonOff(button: Shops)
            topicBool[3] = false
        }
    }
    
    @IBAction func Aaction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 3
        if !topicBool[2] {
            if topicBool[0] {
               
                topicBool[0] = false
            }
            buttonOn(button: Art, topicNum: 3)
            topicBool[2] = true
        }
        else {
            buttonOff(button: Art)
            topicBool[2] = false
        }
    }
    
    @IBAction func Naction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 2
        if !topicBool[1] {
            if topicBool[0] {
               
                topicBool[0] = false
            }
            buttonOn(button: Nightlife, topicNum: 2)
            topicBool[1] = true
        }
        else {
            buttonOff(button: Nightlife)
            topicBool[1] = false
        }
    }
    
    @IBAction func Faction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 1
        if !topicBool[0] {
            if topicBool[0] {
               
                topicBool[0] = false
            }
            buttonOn(button: Food, topicNum: 1)
            topicBool[0] = true
        }
        else {
            buttonOff(button: Food)
            topicBool[0] = false
        }
        
    }
    
    
    @IBOutlet weak var Tourism: UICustomButton!
    @IBOutlet weak var Shops: UICustomButton!
    @IBOutlet weak var Art: UICustomButton!
    @IBOutlet weak var Nightlife: UICustomButton!
    @IBOutlet weak var Food: UICustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Tourism.borderColor = UIColor.gray.cgColor
        Shops.borderColor = UIColor.gray.cgColor
        Art.borderColor = UIColor.gray.cgColor
        Food.borderColor = UIColor.gray.cgColor
        Nightlife.borderColor = UIColor.gray.cgColor
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func buttonOn(button: UICustomButton, topicNum: Int) {
        
        switch topicNum {
        case 0:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.mainColor}))
        case 1:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.foodColor}))
        case 2:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.nightlifeColor}))
        case 3:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.artColor}))
        case 4:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.shopsColor}))
        case 5:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.cityInfoColor}))
        case 6:
            UIView.animate(withDuration: 0.3, animations: ({button.backgroundColor = DataManager.shared.tourismColor}))
        default:
            print("")
        }
        
        UIView.animate(withDuration: 0.3, animations: ({button.layer.borderColor = UIColor.white.cgColor}))
        
        UIView.animate(withDuration: 0.3, animations:  ({button.setTitleColor(UIColor.white, for: UIControlState.normal)}))
    }
    
    func buttonOff(button: UICustomButton) {
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({button.backgroundColor = UIColor.white}))
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({button.layer.borderColor = UIColor.gray.cgColor}))
        
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({button.setTitleColor(UIColor.gray, for: UIControlState.normal)}))
        
        //        button.backgroundColor = UIColor.white
        //        button.layer.borderColor = UIColor.black.cgColor
        //        button.setTitleColor(UIColor.black, for: UIControlState.normal)
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
