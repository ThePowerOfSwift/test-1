//
//  SecondaScrollViewController.swift
//  BatChat
//
//  Created by Lorenzo Caso on 11/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class SecondaScrollViewController: UIViewController {

    
    
    @IBOutlet weak var TourismButton: UICustomButton!
    @IBOutlet weak var NightLifeButton: UICustomButton!
    @IBOutlet weak var FoodButton: UICustomButton!
    @IBOutlet weak var ArtButton: UICustomButton!
     @IBOutlet weak var Tourism2Button: UICustomButton!
    
    
    @IBAction func tourismButtonTap(_ sender: Any) {
        if !topicBool[1] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: TourismButton, topicNum: 1)
            topicBool[1] = true
        }
        else {
            buttonOff(button: TourismButton)
            topicBool[1] = false
        }
    }
    
    @IBAction func nightlifeButtonTap(_ sender: Any) {
        if !topicBool[2] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: NightLifeButton, topicNum: 2)
            topicBool[2] = true
        }
        else {
            buttonOff(button: NightLifeButton)
            topicBool[2] = false
        }
    }
    
    @IBAction func foodButtonTap(_ sender: Any) {
        if !topicBool[3] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: FoodButton, topicNum: 3)
            topicBool[3] = true
        }
        else {
            buttonOff(button: FoodButton)
            topicBool[3] = false
        }
    }
    
    @IBAction func artButtonTap(_ sender: Any) {
        if !topicBool[4] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: ArtButton, topicNum: 4)
            topicBool[4] = true
        }
        else {
            buttonOff(button: ArtButton)
            topicBool[4] = false
        }
    }
    
    
    
    @IBAction func Tourism2Tap(_ sender: Any) {
        
        if !topicBool[6] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: Tourism2Button, topicNum: 6)
            topicBool[6] = true
        }
        else {
            buttonOff(button: Tourism2Button)
            topicBool[6] = false
        }
    }
    
}
extension DrawerContentViewController {
    private func buttonOn(button: UICustomButton, topicNum: Int) {
        
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
        
        //            UIView.animate(withDuration: 0.3,
        //
        //                           animations: ({button.backgroundColor = UIColor.blue}))
        
        UIView.animate(withDuration: 0.3, animations: ({button.layer.borderColor = UIColor.white.cgColor}))
        
        UIView.animate(withDuration: 0.3, animations:  ({button.setTitleColor(UIColor.white, for: UIControlState.normal)}))
        
        //        button.backgroundColor = UIColor.blue
        //        button.layer.borderColor = UIColor.white.cgColor
        //        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        
    }
    /*
     se è un evento colori solo il bordo if-- switch
     se è una chat coloro tutto
     */
    
    private func buttonOff(button: UICustomButton) {
        
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
    
    private func allButtonsOff() {
        buttonOff(button: TourismButton)
        buttonOff(button: NightLifeButton)
        buttonOff(button: FoodButton)
        buttonOff(button: ArtButton)
        buttonOff(button: CityInfoButton)
        buttonOff(button: Tourism2Button)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        CityInfoButton.borderColor = UIColor.gray.cgColor
        Tourism2Button.borderColor = UIColor.gray.cgColor
        TourismButton.borderColor = UIColor.gray.cgColor
        ArtButton.borderColor = UIColor.gray.cgColor
        
        FoodButton.borderColor = UIColor.gray.cgColor
        
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
