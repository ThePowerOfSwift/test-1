//
//  EventViewController.swift
//  BatChat
//
//  Created by Sofia Passarelli on 05/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import AVFoundation


class EventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
//    @IBOutlet weak var previewView: UIView!
//    @IBOutlet weak var captureImageView: UIImageView!
//    
//    @IBAction func didTakePhoto(_ sender: Any) {
//        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
//        self.pickerController.sourceType = .camera // scelgo il sourceType, cioè il luogo in cui pescare le immagini
//        
//        // visualizzo l'imagePickerController
//        present(self.pickerController, animated: true, completion: nil)
//    }
//    @IBOutlet weak var didTakePhotoOutlat: UIButton!
//    
//    @IBAction func importoFromGalleryButton(_ sender: Any) {
//        self.pickerController.allowsEditing = true // blocco la possibilità di editare le foto/video
//        self.pickerController.sourceType = .photoLibrary // scelgo il sourceType, cioè il luogo in cui pescare le immagini
//        
//        // visualizzo l'imagePickerController
//        present(self.pickerController, animated: true, completion: nil)
//    }
//    @IBOutlet weak var importFromGalleryOutlet: UIButton!
//    
//    
//    var pickerController = UIImagePickerController()
//    var session: AVCaptureSession?
//    var stillImageOutput: AVCaptureStillImageOutput?
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        let posizione = CGPoint(x: 300, y: 300)
//        didTakePhotoOutlat.frame.origin = posizione
//        importFromGalleryOutlet.frame.origin = CGPoint(x: 0, y: 300)
//        
//        self.pickerController = UIImagePickerController()
//        self.pickerController.delegate = self
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        videoPreviewLayer!.frame = previewView.bounds
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // Setup your camera here...
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
//        previewView.layer.addSublayer(videoPreviewLayer!)
//        session!.startRunning()
//    }
//    
//    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        captureImageView.image = image
//        captureImageView.contentMode = .scaleAspectFill
//        picker.dismiss(animated: true, completion: nil)
//    }
//    
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        print("l'utente ha chiuso l'ImagePickerController")
//        self.dismiss(animated: true, completion: nil)
//    }
    
    
}

