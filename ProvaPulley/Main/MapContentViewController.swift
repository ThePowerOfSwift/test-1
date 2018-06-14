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
        
        
        navigationController?.isNavigationBarHidden = true
//        per ottenere la miglior location dell'user
        manager.desiredAccuracy = kCLLocationAccuracyBest
   
//        richiede l'autorizzazione
        manager.requestWhenInUseAuthorization()
//        chiede al manager di aggiornare la posizione
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(createAnnotation(not:)), name: NSNotification.Name(rawValue: "createAnnotation"), object: nil)
       
    }
    
    
    @objc func createAnnotation(not:Notification){
        let touchp = not.object
        
        guard (touchp as? CGPoint ) != nil else {
            print("non fun<")
            return
        }
        
        print("FUNZIONA?:\((touchp as! CGPoint).x)")
        let location =  CLLocationCoordinate2D(latitude: (CLLocationDegrees((touchp as! CGPoint).x)), longitude: CLLocationDegrees((touchp as! CGPoint).y))
//        self.mappe.setRegion(MKCoordinateRegionMakeWithDistance(location, 100, 100), animated: true)
        
     
            let marker = MKPointAnnotation()
            
            marker.coordinate = location
            print( marker.coordinate)
            marker.title = "3"
            self.anntVett.append(marker)
            print("APPEND")
        
        
        
        
        
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
        retrieveQuestionsAndEventsAroundRadar(radar: radar)
        
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
    
    
    func retrieveQuestionsAndEventsAroundRadar(radar:DBRadar){
        SingletonServer.singleton.POST_Questions_EventsAroundPosition(radar: radar) { (result) in
            
            let decoder = JSONDecoder()
            let data = result?.data(using: .utf8)
            do{
                
                let e_o = try decoder.decode(Events_QuestionsInSpecificRadar.self, from: data!)
//                SingletonServer.singleton.saveEvents_QuestionsInSpecificRadarState(json: result!, e_q: e_o)
               
                if(e_o.events != nil){
                SingletonServer.singleton.ordinaEventi(eventi: e_o.events!)
                }
                if(e_o.questions != nil){
                    SingletonServer.singleton.ordinaDomande(domande: e_o.questions!)
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "data"), object: nil)
                    self.removeCircle(circle: self.oldCircle)
                    self.oldCircle = self.showCircle(coordinate: CLLocationCoordinate2D(latitude: radar.posX!, longitude: radar.posY!), radius: self.raggio!)
                    self.removeAnnotationEvents()
                    self.addAnnotationEvents()
                    

                    
                }
                
//                if(e_o.events != nil){
//                    for event in e_o.events!{
//                        print(event.name)
//                        print(event.topic)
//
//                    }
//                }
//                if(e_o.questions != nil){
//                    for question in e_o.questions!{
//                        print(question.text)
//
//                    }
//                }
            }catch{
                print("errore di serializzazione")
            }
            
            
        }
    }
    
    
    func addAnnotationEvents(){
        for e in SingletonServer.singleton.eventiOrdinatiPerTopic[1]{
            let marker = MKPointAnnotation()
            
            marker.coordinate = CLLocationCoordinate2D(latitude: (e.myPosition?.posX)!, longitude: (e.myPosition?.posY)!)
            
            marker.title = "\(e.name!)"
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
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation.title == "1"){
            let annotationView = MKAnnotationView()
            annotationView.image = UIImage(named: "arrow2")
            //        let transform = CGAffineTransform(scaleX: 10, y: 10)
            //        annotationView.transform = transform
            return annotationView
        }else if(annotation.title == "2"){
            let annotationView = MKAnnotationView()
            annotationView.image = UIImage(named: "arrow2")
            //        let transform = CGAffineTransform(scaleX: 10, y: 10)
            //        annotationView.transform = transform
            return annotationView
        }
        
        return nil
        
    }

  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension MapContentViewController {
    convenience init() {
        self.init()
        
    }
}


