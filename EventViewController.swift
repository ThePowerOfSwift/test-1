import UIKit
import AVFoundation

class EventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
   
    @IBAction func Cancelac(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate
        
        let initViewController: UIViewController = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as! SelectedViewController
        appDelegate?.window??.rootViewController = initViewController
        
        
    }
    
    @IBOutlet weak var captureImageView: UIImageView!
    
    
    @IBOutlet weak var descrizione: UITextField!
    
    
    
    
//
//    @IBAction func Apri(_ sender: Any) {
//        UIView.animate(withDuration: 0.8, animations: {(self.apriButton.frame.origin.y += 140)})
//        //apriButton.frame.origin.x = 20
//
//        UIView.animate(withDuration: 0.8, delay: 0.0,options: [],
//
//                       animations: ({ self.apriButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))}))
//
//    }
//
    @IBAction func photo2(_ sender: Any) {
        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
        self.pickerController.sourceType = .camera // scelgo il sourceType, cioè il luogo in cui pescare le immagini
        
        // visualizzo l'imagePickerController
        present(self.pickerController, animated: true, completion: nil)
        
    }
    @IBAction func gallery2(_ sender: Any) {
        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
        self.pickerController.sourceType = .photoLibrary // scelgo il sourceType, cioè il luogo in cui pescare le immagini
        
        // visualizzo l'imagePickerController
        present(self.pickerController, animated: true, completion: nil)
        
    }
    @IBAction func didTakePhoto(_ sender: Any) {
        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
        self.pickerController.sourceType = .camera // scelgo il sourceType, cioè il luogo in cui pescare le immagini
        
        // visualizzo l'imagePickerController
        present(self.pickerController, animated: true, completion: nil)
    }
    @IBOutlet weak var didTakePhotoOutlat: UIButton!
    
    @IBAction func importoFromGalleryButton(_ sender: Any) {
        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
        self.pickerController.sourceType = .photoLibrary // scelgo il sourceType, cioè il luogo in cui pescare le immagini
        
        // visualizzo l'imagePickerController
        present(self.pickerController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var importFromGalleryOutlet: UIButton!
    
    @IBOutlet weak var nomeevento: UITextField!
    @IBOutlet weak var eventpos: UITextField!
    @IBOutlet weak var pickerDataInizio: UIDatePicker!
    
    var pickerController = UIImagePickerController()
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    
    @IBAction func done(_ sender: Any) {
       
        var dataInizio = pickerDataInizio.date.description
        var dataFine = pickerData.date.description
        for _ in 1...6 {
            dataInizio = String(dataInizio.dropLast())
            dataFine = String(dataFine.dropLast())
        }
        
        let topic = SingletonServer.singleton.chosenTopic
        SingletonServer.singleton.chosenTopic = 0
        let event = DBEvent(name: nomeevento.text!, description: descrizione.text!, media: "medi", address: eventpos.text!, radar: (SingletonServer.singleton.user?.posFit)!, user: SingletonServer.singleton.user!, datetime: dataInizio, endDate: dataFine, topic: Int32(topic))
        createNewEvent(event: event)
    }
    
    
    func createNewEvent(event:DBEvent){
        
        let touchp = CGPoint(x: (SingletonServer.singleton.user?.posFit?.posX!)!, y: (SingletonServer.singleton.user?.posFit?.posY!)!)
        
        NotificationCenter.default.post(name: NSNotification.Name("createAnnotation"), object: touchp, userInfo: nil)

        SingletonServer.singleton.POST_insertNewEvent(event: event) { (result) in
            let decoder = JSONDecoder()
            let da = result?.data(using: .utf8)
            
            do{
                let e = try decoder.decode(DBEvent.self, from: da!)
                
                if(e.id != 0){
                    
                    print("CIAOO")
//                    SingletonServer.singleton.user?.myEvents?.append(e)
//                    SingletonServer.singleton.saveUserState(user: SingletonServer.singleton.user!)
//                    SingletonServer.singleton.events_questions_aroundPosition?.events?.append(e)
//                    SingletonServer.singleton.saveEvents_QuestionsInSpecificRadarState(e_q: SingletonServer.singleton.events_questions_aroundPosition!)
                    
                    SingletonServer.singleton.user?.myEvents?.append(e)
                    SingletonServer.singleton.eventiOrdinatiPerTopic[Int(e.topic!)].append(e)
                    
                }
            }catch{
                print("errore di serializzazione|LATOCLIENT")
            }
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        eventpos.layer.cornerRadius = 5.0
        eventpos.clipsToBounds = true
        nomeevento.layer.cornerRadius = 5.0
        nomeevento.clipsToBounds = true
        hideKeyboardWhenTappedAround()
        descrizione.layer.cornerRadius = 4.0
        descrizione.clipsToBounds = true
        captureImageView.backgroundColor = .gray
        let posizione = CGPoint(x: 300, y: 300)
        didTakePhotoOutlat.frame.origin = posizione
        importFromGalleryOutlet.frame.origin = CGPoint(x: 0, y: 300)
        
        self.pickerController = UIImagePickerController()
        self.pickerController.delegate = self
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Setup your camera here...
//        session = AVCaptureSession()
//        session!.sessionPreset = AVCaptureSession.Preset.photo
//
//        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
//
//        var error: NSError?
//        var input: AVCaptureDeviceInput!
//        do {
//            input = try AVCaptureDeviceInput(device: backCamera!)
//        } catch let error1 as NSError {
//            error = error1
//            input = nil
//            print(error!.localizedDescription)
//        }
//
//        if error == nil && session!.canAddInput(input) {
//            session!.addInput(input)
//            // ...
//            // The remainder of the session setup will go here...
//        }
//
//        stillImageOutput = AVCaptureStillImageOutput()
//        stillImageOutput?.outputSettings = [AVVideoCodecKey: AVVideoCodecType.jpeg]
//
//        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
//        videoPreviewLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
//        videoPreviewLayer!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
//
//        session!.startRunning()
    }
    
    @IBOutlet weak var pickerData: UIDatePicker!
    
    @IBOutlet weak var photo2: UIButton!
    
    @IBOutlet weak var gallery2: UIButton!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        photo2.isHidden = false
        gallery2.isHidden = false
        importFromGalleryOutlet.isHidden = true
        didTakePhotoOutlat.isHidden  = true
        
        // captureImageView.isHidden = !captureImageView.isHidden
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        captureImageView.image = image
        //captureImageView.contentMode = .scaleAspectFill
        captureImageView.contentMode = .scaleAspectFit
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("l'utente ha chiuso l'ImagePickerController")
        self.dismiss(animated: true, completion: nil)
    }
    
   
    
}

