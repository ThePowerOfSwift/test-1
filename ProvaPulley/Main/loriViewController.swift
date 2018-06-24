//
//  ViewController.swift
//  tabletest
//
//  Created by Luca Galeota on 08/06/18.
//  Copyright © 2018 Luca Galeota. All rights reserved.
//

import UIKit

class loriViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    
    var open = false
    
    @IBOutlet weak var moreInfoView: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var viewDellaPicker: UIView!
    
    @IBOutlet weak var buttonNow: UIButton!
    
    @IBOutlet weak var timePickerStart: UIDatePicker!

    @IBOutlet weak var timePickerEnd: UIDatePicker!
    
   
    @IBOutlet weak var descrizione: UITextView!
    @IBOutlet weak var eventopos: UITextField!
    @IBOutlet weak var greyView: UIView!
    @IBOutlet weak var nomeevento: UITextField!
    var tastieraSu = false
    
    @IBOutlet weak var captureImageView: UIImageView!
    
    @IBOutlet weak var hours: UIButton!
    
    @objc func tastieraDentro (notifica: Notification) {
        tastieraInOut (su:false, notifica: notifica)
    }
    
    
    
    @objc func tastieraFuori (notifica: Notification) {
        tastieraInOut (su:true, notifica: notifica)
    }
    
    func tastieraInOut (su:Bool,  notifica:Notification) {
        guard su != tastieraSu else {
            return
            
        }
        let info = notifica.userInfo
        let fineTastiera: CGRect = ((info?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)!
        
        let durataAnimazione: TimeInterval = info? [UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate (withDuration: durataAnimazione, delay: 0, options:
            .curveEaseInOut, animations: {
                let dimensioneTastiera = self.view.convert (fineTastiera, to:nil)
                let spostamentoVerticale = dimensioneTastiera.size.height * (su ? -1 : 1)
                self.view.frame = self.view.frame.offsetBy( dx: 0, dy: spostamentoVerticale)
                self.tastieraSu = !self.tastieraSu
        }, completion:
            { success in
                if !self.tastieraSu {
//                    let indice = IndexPath.init(row: self.messaggi.count - 1, section: 0)
//                    self.tableview.scrollToRow(at: indice, at: .top, animated: true)
                }
        }
            
        )
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fa sparire tutte le view
        
        if nomeevento.isEditing == true{
            open = true
        }else{
            open = true
        }
        NotificationCenter.default.addObserver(self, selector: #selector(ConversazionViewController.tastieraFuori(notifica:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ConversazionViewController.tastieraDentro(notifica:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        viewDellaPicker.alpha = 0
        viewDellaPicker.layer.cornerRadius = 15
        viewDellaPicker.frame.origin.y = 680
        greyView.alpha = 0
        timePickerStart.alpha = 0
        timePickerEnd.alpha = 0
        
        hideKeyboardWhenTappedAround()
        self.nomeevento.delegate = self
        self.descrizione.delegate = self
        self.eventopos.delegate = self
        
        self.pickerController = UIImagePickerController()
        self.pickerController.delegate = self

        descrizione.layer.borderWidth = 1.0
        descrizione.layer.borderColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 231/255.0, alpha: 1).cgColor
        descrizione.layer.cornerRadius = 5.0
        descrizione.clipsToBounds = true
    
        
        descrizione.text = "Enter your description"
        descrizione.textColor = UIColor.lightGray
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descrizione.textColor == UIColor.lightGray {
            descrizione.text = nil
            descrizione.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descrizione.text.isEmpty {
            descrizione.text = "Enter your description"
            descrizione.textColor = UIColor.lightGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func done(_ sender: Any) {
        let topic = SingletonServer.singleton.chosenTopic
        
        if (nomeevento.text != "")  && (topic != 0) {
            
            var dataInizio = timePickerStart.date.description
            //        var dataFine = timePickerEnd.date.description
            let calendar = Calendar.current
            let d = calendar.date(byAdding: DateComponents(calendar: calendar, hour: 4, minute: 00, second: 00), to: timePickerEnd.date)
            
            var dataFine = d?.description
            for _ in 1...6 {
                dataInizio = String(dataInizio.dropLast())
                dataFine = String((dataFine?.dropLast())!)
            }
            //        print ("DATA INIZIO: \(dataInizio) e \(dataFine!)")
            let topic = SingletonServer.singleton.chosenTopic
            print("TOPIC:\(topic)")
            SingletonServer.singleton.chosenTopic = 0
            let image = captureImageView.image
            
            
            
            var string = "\(topic)"
            if(image != nil){
                let data: Data = UIImageJPEGRepresentation(image!, 0.5)!
                string = data.base64EncodedString(options: .lineLength64Characters)
            }
            
            var radar:DBRadar = (SingletonServer.singleton.user?.posReal)!
            if  let r = SingletonServer.singleton.user?.posFit {
                radar = r
            }
            
            let event = DBEvent(name: nomeevento.text!, description: descrizione.text!, media: string, address: eventopos.text!, radar: radar, user: SingletonServer.singleton.user!, datetime: dataInizio, endDate: dataFine!, topic: Int32(topic))
            createNewEvent(event: event)
            
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            print ("nulla")
            //            qua <<<
            let alert = UIAlertController(title: "", message: "Please choose one Topic and add an Event Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func createNewEvent(event:DBEvent){
        SingletonServer.singleton.POST_insertNewEvent(event: event) { (result) in
            let decoder = JSONDecoder()
            let da = result?.data(using: .utf8)
            
            do{
                let e = try decoder.decode(DBEvent.self, from: da!)
                
                if(e.id != 0){
                    DispatchQueue.main.async {
                        SingletonServer.singleton.user?.myEvents?.append(e)
                        SingletonServer.singleton.eventiOrdinatiPerTopic[Int(e.topic!)].append(e)
                        SingletonServer.singleton.eventiOrdinatiPerTopic[0].append(e)
                        SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "data"), object: nil)
                        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: nil, userInfo: nil)
                    }
                }
            }catch{
                print("errore di serializzazione|LATOCLIENT")
            }
            
            
        }
    }
    
    
    @IBAction func didTakePhoto(_ sender: Any) {
//        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
        self.pickerController.sourceType = .camera // scelgo il sourceType, cioè il luogo in cui pescare le immagini
        pickerController.delegate = self
        
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
        
        
        captureImageView.image = image
        
        captureImageView.contentMode = .scaleAspectFit
//        captureImageView.contentMode = .scaleAspectFill
//        captureImageView.contentMode = .scaleToFill
        picker.dismiss(animated: true, completion: nil)
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//         let image = info[UIImagePickerControllerOriginalImage] as! UIImage
////        let image = UIImage(cgImage: info[UIImagePickerControllerOriginalImage] as! CGImage, scale: 1, orientation: .up)
//
//        let rect: CGRect = CGRect(x: 0, y: 0, width: 5000, height: 5000)
//
//        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
//
////        let croppedImage:UIImage = UIImage(cgImage: imageRef)
//        let croppedImage = UIImage(cgImage: imageRef as! CGImage, scale: 1, orientation: .down)
//
//        captureImageView.image = croppedImage
////        captureImageView.transform = captureImageView.transform.rotated(by: CGFloat.pi/2)
//
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    
    
    @IBAction func Cancelac(_ sender: Any) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let appDelegate = UIApplication.shared.delegate
//        
//        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! SelectedViewController
//        appDelegate?.window??.rootViewController = initViewController
        navigationController?.popToRootViewController(animated: true)
       
        dismiss(animated: true, completion: nil)
        
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

        
            
        let calendarStart = Calendar.current
        let monthStart = calendarStart.component(.month, from: timePickerStart.date)
        let dayStart = calendarStart.component(.day, from: timePickerStart.date)
        let hourStart = calendarStart.component(.hour, from: timePickerStart.date)
        
        let monthEnd = calendarStart.component(.month, from: timePickerEnd.date)
        let dayEnd = calendarStart.component(.day, from: timePickerEnd.date)
        let hourEnd = calendarStart.component(.hour, from: timePickerEnd.date)
       
        
        
        hours.titleLabel?.text = "\((monthEnd-monthStart)*24*30 + (dayEnd-dayStart)*24 + (hourEnd-hourStart))+"
        
        
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

