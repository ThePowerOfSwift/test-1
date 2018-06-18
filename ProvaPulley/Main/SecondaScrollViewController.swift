
//  SecondaScrollViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 11/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class SecondaScrollViewController: UIViewController {
    
    var vetButtons: [UICustomButton] = []
    
    @IBOutlet weak var Tourism: UICustomButton!
    @IBOutlet weak var Shops: UICustomButton!
    @IBOutlet weak var Art: UICustomButton!
    @IBOutlet weak var Nightlife: UICustomButton!
    @IBOutlet weak var Food: UICustomButton!
    
    @IBAction func Taction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 6
        self.allButtonsOff(i: 4)
        buttonOn(topicNum: 4)
    }
    
    
    @IBAction func Saction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 4
        self.allButtonsOff(i: 3)
        buttonOn(topicNum: 3)
    }
    
    
    @IBAction func Aaction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 3
        self.allButtonsOff(i: 2)
        buttonOn(topicNum: 2)
    }
    
    
    @IBAction func Naction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 2
        self.allButtonsOff(i: 1)
        buttonOn(topicNum: 1)
    }
    
    
    @IBAction func Faction(_ sender: Any) {
        SingletonServer.singleton.chosenTopic = 1
        self.allButtonsOff(i: 0)
        buttonOn(topicNum: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tourism.borderColor = UIColor.gray.cgColor
        Shops.borderColor = UIColor.gray.cgColor
        Art.borderColor = UIColor.gray.cgColor
        Food.borderColor = UIColor.gray.cgColor
        Nightlife.borderColor = UIColor.gray.cgColor
        
        self.vetButtons = [self.self.Food, self.Nightlife, self.Art, self.Shops, self.Tourism]
        
        // Do any additional setup after loading the view.
    }
    
    private func buttonOn(topicNum: Int) {
        
        switch topicNum {
        case 0:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.foodColor}))
        case 1:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.nightlifeColor}))
        case 2:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.artColor}))
        case 3:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.shopsColor}))
        case 4:
            UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].backgroundColor = DataManager.shared.tourismColor}))
        default:
            print("")
        }
        
        UIView.animate(withDuration: 0.3, animations: ({self.vetButtons[topicNum].layer.borderColor = UIColor.white.cgColor}))
        
        UIView.animate(withDuration: 0.3, animations:  ({self.vetButtons[topicNum].setTitleColor(UIColor.white, for: UIControlState.normal)}))
    }
    
    private func buttonOff(i: Int) {
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({self.vetButtons[i].backgroundColor = UIColor.white}))
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({self.vetButtons[i].layer.borderColor = UIColor.gray.cgColor}))
        
        
        UIView.animate(withDuration: 0.25,
                       
                       animations: ({self.vetButtons[i].setTitleColor(UIColor.gray, for: UIControlState.normal)}))
        
        //        button.backgroundColor = UIColor.white
        //        button.layer.borderColor = UIColor.black.cgColor
        //        button.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    private func allButtonsOff(i:Int) {
        for cont in 0...4{
            if(cont != i){
                buttonOff(i: cont)
            }
        }
        
    }
}
