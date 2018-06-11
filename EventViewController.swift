import UIKit
import AVFoundation

class EventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    @IBOutlet weak var captureImageView: UIImageView!
    
    
    
    
    
    
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
    
    
    var pickerController = UIImagePickerController()
    var session: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

