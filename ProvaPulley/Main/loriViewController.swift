//
//  ViewController.swift
//  tabletest
//
//  Created by Luca Galeota on 08/06/18.
//  Copyright © 2018 Luca Galeota. All rights reserved.
//

import UIKit

class loriViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    var open = false
    
    @IBOutlet weak var moreInfoView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var viewDellaPicker: UIView!
    
    @IBOutlet weak var buttonNow: UIButton!
    
    @IBOutlet weak var timePickerStart: UIDatePicker!

    @IBOutlet weak var timePickerEnd: UIDatePicker!
    
    @IBOutlet weak var greyView: UIView!
    
    
    @IBOutlet weak var captureImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fa sparire tutte le view
        
        viewDellaPicker.alpha = 0
        viewDellaPicker.layer.cornerRadius = 15
        viewDellaPicker.frame.origin.y = 680
        greyView.alpha = 0
        timePickerStart.alpha = 0
        timePickerEnd.alpha = 0
        
        hideKeyboardWhenTappedAround()
        
        self.pickerController = UIImagePickerController()
        self.pickerController.delegate = self

        
    }

//    @IBAction func done(_ sender: Any) {
//        
//        var dataInizio = pickerDataInizio.date.description
//        var dataFine = pickerData.date.description
//        for _ in 1...6 {
//            dataInizio = String(dataInizio.dropLast())
//            dataFine = String(dataFine.dropLast())
//        }
//        
//        let topic = SingletonServer.singleton.chosenTopic
//        SingletonServer.singleton.chosenTopic = 0
//        let event = DBEvent(name: nomeevento.text!, description: descrizione.text!, media: "medi", address: eventpos.text!, radar: (SingletonServer.singleton.user?.posFit)!, user: SingletonServer.singleton.user!, datetime: dataInizio, endDate: dataFine, topic: Int32(topic))
//        createNewEvent(event: event)
//    }
    
    @IBAction func didTakePhoto(_ sender: Any) {
        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
        self.pickerController.sourceType = .camera // scelgo il sourceType, cioè il luogo in cui pescare le immagini
        
        // visualizzo l'imagePickerController
        present(self.pickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func importoFromGalleryButton(_ sender: Any) {
        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
        self.pickerController.sourceType = .photoLibrary // scelgo il sourceType, cioè il luogo in cui pescare le immagini
        
        // visualizzo l'imagePickerController
        present(self.pickerController, animated: true, completion: nil)
        
    }
    var pickerController = UIImagePickerController()
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: 5000, height: 5000)
        
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        
        let croppedImage:UIImage = UIImage(cgImage: imageRef)
        
        captureImageView.image = croppedImage
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func Cancelac(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate
        
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! SelectedViewController
        appDelegate?.window??.rootViewController = initViewController
        
        
    }
    @IBAction func cancpicker(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate
        
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "loriViewController") as! loriViewController
        appDelegate?.window??.rootViewController = initViewController
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    @IBAction func cancelTimeStart(_ sender: Any) { // cancelButton

        closeViewDellaPicker()
        
    }
    
    func closeViewDellaPicker() {
        
                UIView.animate(withDuration: 0.35,
        
                               animations: ({self.greyView.alpha = 0}))
        
        
                UIView.animate(withDuration: 0.35,
        
                               animations: ({self.viewDellaPicker.frame.origin.y = 680}))
        
        
                timePickerStart.alpha = 0
        
                timePickerEnd.alpha = 0

        
    }
    
    @IBAction func setTimeStart(_ sender: Any) { // doneButton

//        if timePickerStart.alpha == 1 && timePickerEnd.alpha == 0 {
//        da qua metti il tempo sul tasto NOW e gli cambi l'etichetta
//        }
        


//        oppure creamo un action dal sender del timePickerstart e uno diverso dal timepickerend
        
        

        closeViewDellaPicker()
        

        
        
    }
    
    @IBAction func dismissViewDellaPicker(_ sender: Any) {
        
        closeViewDellaPicker()
        
    }
    
    @IBAction func showStartPicker(_ sender: Any) { // NowButton
    
        viewDellaPicker.alpha = 1
        
        timePickerStart.alpha = 1
        
        UIView.animate(withDuration: 0.35,
                       
                       animations: ({self.viewDellaPicker.frame.origin.y = 338}))
        
        UIView.animate(withDuration: 0.35,
                       
                       animations: ({self.greyView.alpha = 0.75}))
        
        
        
    }
    
    @IBAction func showEndPicker(_ sender: Any) { // +4hrsButton
        
        viewDellaPicker.alpha = 1
        
        timePickerEnd.alpha = 1
        
        UIView.animate(withDuration: 0.35,
                       
                       animations: ({self.viewDellaPicker.frame.origin.y = 338}))
        
        UIView.animate(withDuration: 0.35,
                       
                       animations: ({self.greyView.alpha = 0.75}))
        
        
        
    }
    
    @IBAction func move(_ sender: Any) {
        
        if open == false {
            
        
                            UIView.animate(withDuration: 1, animations: ({ self.moreInfoView.frame.origin.y = 605 }))


            
                            UIView.animate(withDuration: 0.8, delay: 0.2,
                           
                            animations: ({self.button.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*(1)))}))
        
                            open = true
            
            } else {
            
                            UIView.animate(withDuration: 1, animations: ({ self.moreInfoView.frame.origin.y = 378 }))


            
                            UIView.animate(withDuration: 0.8, delay: 0.2,
                           
                            animations: ({self.button.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi*(-2)))}))
            
            
                            open = false
            
            
        }
        
    }
    
}

