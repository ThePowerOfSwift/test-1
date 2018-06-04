//
//  PuViewController.swift
//  ProvaPulley
//
//  Created by Lorenzo Caso on 22/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import Pulley
import QuartzCore



class DrawerContentViewController: UIViewController, UITabBarDelegate, UITableViewDelegate{
    
    static var i=0
    
    @IBOutlet weak var Gripper: UIView!
    @IBOutlet weak var AskQuestionTextField: UITextField!
    
    @IBOutlet weak var AnyButton: UICustomButton!
    @IBOutlet weak var TourismButton: UICustomButton!
    @IBOutlet weak var NightLifeButton: UICustomButton!
    @IBOutlet weak var FoodButton: UICustomButton!
    @IBOutlet weak var ArtButton: UICustomButton!
    @IBOutlet weak var CityInfoButton: UICustomButton!
    @IBOutlet weak var ShopsButton: UICustomButton!
    
    @IBOutlet weak var messageTable: UITableView!
    
    var topicBool: [Bool] = [true, false, false, false, false, false, false]

    // inizializzazine nuovo evento
    var newEvent = Event(title: "Party", description: "Venite", topic: .nightLife, id: true )
    var newMessage = Message(author: User(nickname: "toni", imageNum: 2), message: "Dove posso bebebebe", topic: .cityLife, id: true)

    
    override func viewDidLoad() {
         super.viewDidLoad()
        


    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
          
     
    }

  
    
    @IBAction func askQuestion(_ sender: Any) {
        self.pulleyViewController?.setDrawerPosition(position: .open, animated: true)
    }
    
    
    @IBAction func Cancel(_ sender: Any) {
        dismissKeyboard()
    self.pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        
    }
    
    @IBAction func anyButtonTap(_ sender: Any) {
        if !topicBool[0] {
            for i in 1...6 {
                self.topicBool[i] = false
            }
            allButtonsOff()
            
            buttonOn(button: AnyButton)
            topicBool[0] = true
        }
        else {
            buttonOff(button: AnyButton)
            topicBool[0] = false
        }
        
    }
    
    @IBAction func tourismButtonTap(_ sender: Any) {
        if !topicBool[1] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: TourismButton)
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
            buttonOn(button: NightLifeButton)
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
            buttonOn(button: FoodButton)
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
            buttonOn(button: ArtButton)
            topicBool[4] = true
        }
        else {
            buttonOff(button: ArtButton)
            topicBool[4] = false
        }
    }
    
    @IBAction func cityinfoButtonTap(_ sender: Any) {
        if !topicBool[5] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: CityInfoButton)
            topicBool[5] = true
        }
        else {
            buttonOff(button: CityInfoButton)
            topicBool[5] = false
        }
    }
    
    @IBAction func shopsButtonTap(_ sender: Any) {
        if !topicBool[6] {
            if topicBool[0] {
                buttonOff(button: AnyButton)
                topicBool[0] = false
            }
            buttonOn(button: ShopsButton)
            topicBool[6] = true
        }
        else {
            buttonOff(button: ShopsButton)
            topicBool[6] = false
        }
    }
    
}

extension DrawerContentViewController {
    private func buttonOn(button: UICustomButton) {
        button.backgroundColor = UIColor.blue
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
    }
    
/*
    se è un evento colori solo il bordo if-- switch
     se è una chat coloro tutto
*/
    
    private func buttonOff(button: UICustomButton) {
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
    }
    
    private func allButtonsOff() {
        buttonOff(button: TourismButton)
        buttonOff(button: NightLifeButton)
        buttonOff(button: FoodButton)
        buttonOff(button: ArtButton)
        buttonOff(button: CityInfoButton)
        buttonOff(button: ShopsButton)
    }
    
    
}

extension DrawerContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.messages.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PulleyTableViewCell
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! PulleyTableViewCell1
        
        if indexPath.row == 0{
          cell.improf.image = #imageLiteral(resourceName: "Lorenzo")
          cell.sfondo.backgroundColor = .red
          cell.desc.text = "Andiamo a ballare? Waju o drag"
          cell.desc.textColor = .white
          cell.nickname.text = "Lorenzo"
          cell.nickname.textColor = .white
          cell.num.layer.cornerRadius = 12.0
          cell.num.clipsToBounds = true
          cell.num.text = "2"
          cell.num.backgroundColor = .white
          cell.num.textColor = .red
          cell.num.textAlignment = .center
          cell.inizio.text = "22:00"
          cell.inizio.textColor = .white
        
        

        return cell
        }else{
            cell1.improf1.image = #imageLiteral(resourceName: "Giorgio")
            cell1.inizio1.text = "22:00"
            cell1.inizio1.textColor = .black
            cell1.num1.text = "14"
            cell1.num1.textColor = .white
            cell1.num1.backgroundColor = .black
            cell1.num1.textAlignment = .center
            cell1.num1.layer.cornerRadius = 12.0
            cell1.num1.clipsToBounds = true
            cell1.desc1.text = "O DRAGGGGGGGGGGGGGGGGGGGGGGGG"
            cell1.desc1.textColor = .black
            cell1.nick1.text = "Giorgia"
            cell1.nick1.textColor = .black
            cell1.divisore.text = "-"
            cell1.divisore.textColor = .black
            cell1.sfondo1.layer.borderWidth = 1
            cell1.fine.text = "2:00"
            cell1.fine.textColor = .black
            cell1.sfondo1.layer.borderColor = UIColor(red: 0/255, green: 90/255, blue: 50/255, alpha: 1.0).cgColor
            return cell1
        }
    }

}




