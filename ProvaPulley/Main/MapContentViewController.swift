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
    let manager = CLLocationManager()
    
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
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        mappe.setRegion(region, animated: true)
        
        
        //        questa riga mi miostra il pallino blu sulla mappa
        self.mappe.showsUserLocation = true
        manager.stopUpdatingLocation()
        
        let marker = MKPointAnnotation()
        
        marker.coordinate = myLocation
        marker.title = "SI STRUNZ"
        
        mappe.addAnnotation(marker)
        mappe.removeAnnotation(marker)
//        self.oldCircle = showCircle(coordinate: myLocation, radius: self.raggio!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 
            DataManager.shared.messages.append(Message(author: User(nickname: "luco", imageNum: 5), message: "eskere", topic: .tourism, id: true))
            
            for touch in touches {
                let radar = DBRadar()
                let touchPoint = touch.location(in: self.mappe)
                radar.posX = Double(1)
                radar.posY = Double(2)
                radar.range = 1000.0
                SingletonServer.singleton.POST_Questions_EventsAroundPosition(radar: radar) { (result) in
                    
                                    let decoder = JSONDecoder()
                                    let data = result?.data(using: .utf8)
                                    do{
                                        let e_o = try decoder.decode(Events_QuestionsInSpecificRadar.self, from: data!)
                                        SingletonServer.singleton.saveEvents_QuestionsInSpecificRadarState(json: result!, e_q: e_o)
                                        
                                        if(e_o.events != nil){
                                            for event in e_o.events!{
                                                print(event.name)
                    
                                            }
                                        }
                                        if(e_o.questions != nil){
                                            for question in e_o.questions!{
                                                print(question.text)
                                                
                                            }
                                        }
                                    }catch{
                                        print("errore di serializzazione")
                                    }
                    
                    
                                }
                
                let location = self.mappe.convert(touchPoint, toCoordinateFrom: self.mappe)
                removeCircle(circle: self.oldCircle)
                self.oldCircle = showCircle(coordinate: location, radius: self.raggio!)
            
            
            //            MessageTableView.messageTableView.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "data"), object: nil)
        }
        
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
        let annotationView = MKAnnotationView()
        annotationView.image = UIImage(named: "arrow2")
//        let transform = CGAffineTransform(scaleX: 10, y: 10)
//        annotationView.transform = transform
        return annotationView
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


