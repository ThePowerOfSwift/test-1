//
//  MapViewController.swift
//  ProvaPulley
//
//  Created by Lorenzo Caso on 23/05/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapContentViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    
    
    let image: UIImage = UIImage(named: "radar")!
    lazy var imageView = UIImageView(image: image)
    
    
    @IBOutlet weak var mappe: MKMapView!
    var oldCircle = MKCircle()
    var raggio = CLLocationDistance(exactly: 1000)
    var anntVett: [MKPointAnnotation] = [MKPointAnnotation]()
    let manager = CLLocationManager()
    var count=0
    var range:Double = 1/111
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mappe.delegate = self
        manager.delegate = self
        print("-------------")
        
        
        
        navigationController?.isNavigationBarHidden = true
        //        per ottenere la miglior location dell'user
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        //        richiede l'autorizzazione
        manager.requestWhenInUseAuthorization()
        //        chiede al manager di aggiornare la posizione
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        
        
        mappe.showsCompass = false
        NotificationCenter.default.addObserver(self, selector: #selector(createAnnotation(not:)), name: NSNotification.Name(rawValue: "createAnnotation"), object: nil)
        
        SingletonServer.singleton.inizializza()
        
        print("entro")
        
        let frameMappa = mappe.frame.size
        imageView.frame = CGRect(x: 0, y: frameMappa.height/8, width: frameMappa.width, height: frameMappa.width)
//        rotateRadar(imageView: imageView, aCircleTime: 2.0)
//        self.mappe.addSubview(imageView)
//        print("SONOQUIIIIIIIIII")
        
    }
    
    
    
    @objc func createAnnotation(not:Notification){
        self.removeAnnotationEvents()
        self.addAnnotationEvents()
        
    }
    
//    Funzione che fa sparire la view del radar quando si muove la mappa
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("Mi sto muovendo sulla mappapppppp")
        self.imageView.removeFromSuperview()
    }
    
//    funzione che fa comparire la view del radar quando si ferma la mappa e la anima
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.view.addSubview(imageView)
        rotateRadar(imageView: imageView, aCircleTime: 2.0)
        print("Ho finito di muovevermi")
        
    }
    
    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance)->MKCircle {
        let circle = MKCircle(center: coordinate, radius: radius)
        mappe.add(circle)
        return circle
    }
    
    func removeCircle(circle:MKCircle) {
        
        mappe.remove(circle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        rotateRadar(imageView: imageView, aCircleTime: 2.0)
    }
    
    
    
    
    //    questa funzione è chiamata ogni volta che la posizione è aggiornata
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        primo elemento dell'array che corrisponde alla posizione più recente
        let location = locations[0]
        
        //        quanto dobbiamo zoommare sulla posizione
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        //        store la posizione dello user
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        //        SingletonServer.singleton.user?.posReal = DBRadar(posX: location.coordinate.latitude, posY: location.coordinate.longitude, range: self.range)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        mappe.setRegion(region, animated: true)
        
        
        //        questa riga mi miostra il pallino blu sulla mappa
        self.mappe.showsUserLocation = true
        
        
        let radar = DBRadar(posX: myLocation.latitude, posY: myLocation.longitude, range: self.range)
//        retrieveQuestionsAndEventsAroundRadar(radar: radar)
        SingletonServer.singleton.user?.posReal = DBRadar(posX: location.coordinate.latitude, posY: location.coordinate.longitude, range: self.range)
       print("UPDATE")
        manager.stopUpdatingLocation()

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if(touch.tapCount==3){
                
                let touchPoint = touch.location(in: self.mappe)
                let location = self.mappe.convert(touchPoint, toCoordinateFrom: self.mappe)
                SingletonServer.singleton.user?.posFit = DBRadar(posX: Double(location.latitude), posY: Double(location.longitude), range: self.range)
                retrieveQuestionsAndEventsAroundRadar(radar:  (SingletonServer.singleton.user?.posFit!)!)
                
            }
        }
    }
    
    //    Funzione che anima la rotazione del radar simulando che funzioni
    
    func rotateRadar(imageView: UIImageView, aCircleTime: Double) { //CABasicAnimation
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2 //Minus can be Direction
        rotationAnimation.duration = aCircleTime
        rotationAnimation.repeatCount = .infinity
        imageView.layer.add(rotationAnimation, forKey: nil)
    }
    
    
    func retrieveQuestionsAndEventsAroundRadar(radar:DBRadar){
        SingletonServer.singleton.POST_Questions_EventsAroundPosition(radar: radar) { (result) in
            
            let decoder = JSONDecoder()
            let data = result?.data(using: .utf8)
            do{
                
                let e_o = try decoder.decode(Events_QuestionsInSpecificRadar.self, from: data!)
                //                SingletonServer.singleton.saveEvents_QuestionsInSpecificRadarState(json: result!, e_q: e_o)
                
                if(e_o.events != nil){
                    SingletonServer.singleton.ordinaEventi(eventi: e_o.events!)
                }else{
                    SingletonServer.singleton.ordinaEventi(eventi:[DBEvent]())
                }
                if(e_o.questions != nil){
                    SingletonServer.singleton.ordinaDomande(domande: e_o.questions!)
                }else{
                    SingletonServer.singleton.ordinaDomande(domande:[DBQuestion]())
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "data"), object: nil)
                    self.removeCircle(circle: self.oldCircle)
                    self.oldCircle = self.showCircle(coordinate: CLLocationCoordinate2D(latitude: radar.posX!, longitude: radar.posY!), radius: self.raggio!)
                    self.removeAnnotationEvents()
                    self.addAnnotationEvents()
                    
                }
                
               
            }catch{
                print("errore di serializzazione")
            }
            
            
        }
    }
    
    
    func addAnnotationEvents(){
        for e in SingletonServer.singleton.eventiOrdinatiPerTopic[SingletonServer.singleton.chosenTopic]{
            let marker = EventAnnotation(coordinate: CLLocationCoordinate2D(latitude: (e.myPosition?.posX)!, longitude: (e.myPosition?.posY)!))
            
            marker.address = e.address
            marker.answers = e.answers
            marker.datetime = e.datetime
            marker.endDate = e.endDate
            marker.id = e.id
            marker.media = e.media
            marker.descri = e.description
            marker.myPosition = e.myPosition
            marker.name = e.name
            
            marker.topic = Int(e.topic!)
         
            self.mappe.addAnnotation(marker)
            
        }
    }
    
    
    func removeAnnotationEvents(){
        self.mappe.removeAnnotations(self.mappe.annotations)
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // If you want to include other shapes, then this check is needed. If you only want circles, then remove it.
        //        if let circleOverlay = overlay as? MKCircle {
        
        let circleOverlay = overlay as? MKCircle
        let circleRenderer = MKCircleRenderer(overlay: circleOverlay!)
        circleRenderer.fillColor = UIColor.black
        circleRenderer.alpha = 0.1
        
        return circleRenderer
        
        
        // You can either return your square here, or ignore the circle check and only return circles.
        
    }
    
    @IBAction func pos(_ sender: Any) {
        manager.startUpdatingLocation()
        SingletonServer.singleton.user?.posFit! = (SingletonServer.singleton.user?.posReal!)!
        retrieveQuestionsAndEventsAroundRadar(radar:  (SingletonServer.singleton.user?.posFit!)!)
    }
    
    //    funzione per cambiare l'immagine del pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let a = annotation as? EventAnnotation
        
        if (a?.topic == 1) {
            let annotationView = MKAnnotationView()
            annotationView.annotation = annotation
            annotationView.image = UIImage(named: "food")
            return annotationView
        } else if (a?.topic == 2) {
            let annotationView = MKAnnotationView()
            annotationView.image = #imageLiteral(resourceName: "nightlife")
            annotationView.annotation = annotation
            return annotationView
        } else if (a?.topic == 3) {
            let annotationView = MKAnnotationView()
            annotationView.annotation = annotation
            annotationView.image = #imageLiteral(resourceName: "art")
            return annotationView
        } else if (a?.topic == 4) {
            let annotationView = MKAnnotationView()
            annotationView.annotation = annotation
            annotationView.image = #imageLiteral(resourceName: "Shopping")
            return annotationView
        } else if (a?.topic == 5) {
            let annotationView = MKAnnotationView()
            annotationView.annotation = annotation
            annotationView.image = #imageLiteral(resourceName: "cityinfo")
            return annotationView
        } else if (a?.topic == 6) {
            let annotationView = MKAnnotationView()
            annotationView.annotation = annotation
            annotationView.image = #imageLiteral(resourceName: "Tourism")
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("idjekfnejkrnjk")
        let event = view.annotation as? EventAnnotation
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "event"), object: event)
    }
    
    
//    fa scomparire il pallino della posizione dell'utente
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let userLocation = mapView.view(for: mapView.userLocation) {
            userLocation.isHidden = true
        }
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "eventoPulley" {
//            let userViewController = segue.destination as! EventoPulleyViewController
//            // TODO: something
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension MapContentViewController {
    convenience init() {
        self.init()
        
    }
    
    //    Funzione per fare il resize dei pin
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}

//extension MapContentViewController: MKMapViewDelegate {
//
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        performSegue(withIdentifier: "eventoPulley", sender: nil)
//    }
//}
//

