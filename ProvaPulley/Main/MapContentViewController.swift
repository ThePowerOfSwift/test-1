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

    static  var annotationEventVett: [EventAnnotation] = [EventAnnotation]()
    
    @IBOutlet weak var mappe: MKMapView!
    var oldCircle = MKCircle()
    var raggio = CLLocationDistance(exactly: 1000)
    
    let manager = CLLocationManager()
    var count=0
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
        
        
        let marker = EventAnnotation(coordinate: location)
        marker.image = UIImage(named: "Food.pdf")
        print( marker.coordinate)
        
        MapContentViewController.annotationEventVett.append(marker)
        
        
        
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
        print("GIRO")
//
//        let point = EventAnnotation(coordinate: CLLocationCoordinate2D(latitude: 40.839905244526754, longitude: 14.326757450415244))
//        point.image = UIImage(named: "FOOD.png")
        for a in MapContentViewController.annotationEventVett{
            self.mappe.addAnnotation(a)
            print("GIRO")
        }
       
        
        
    }
    //    questa funzione è chiamata ogni volta che la posizione è aggiornata
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //        primo elemento dell'array che corrisponde alla posizione più recente
        let location = locations[0]
        
        //        quanto dobbiamo zoommare sulla posizione
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        //        store la posizione dello user
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        print("LOCATION LON:\(location.coordinate.latitude) LATI\(location.coordinate.longitude)")
        SingletonServer.singleton.user?.posReal = DBRadar(posX: location.coordinate.latitude, posY: location.coordinate.longitude, range: 10)
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
        print("TOUCHES\(touches.count)")
            for touch in touches {
                print("COUNT:\(touch.tapCount)")
              print(count)
                        if(touch.tapCount==3){
                            
                                let touchPoint = touch.location(in: self.mappe)
                            print("TOUCH POINT:\(touchPoint.x) e \(touchPoint.y)")
                                let location = self.mappe.convert(touchPoint, toCoordinateFrom: self.mappe)
                            print("LAT e LONG:\(location.latitude) e \(location.longitude)")
                                let t:CGPoint = CGPoint(x: touchPoint.x+1000, y: touchPoint.y+1000)
                                let loc1 = self.mappe.convert(t, toCoordinateFrom: self.mappe)
                                let rangelat = location.latitude-loc1.latitude
                                print("RANGE:\(rangelat)")
                                SingletonServer.singleton.user?.posFit = DBRadar(posX: Double(location.latitude), posY: Double(location.longitude), range: 1/111)
                            print("DOUBLE:\(Double(1/111))")
                                print("RAGGIOOO:\(self.raggio!)")
                            
                                
                                
                                SingletonServer.singleton.POST_Questions_EventsAroundPosition(radar: (SingletonServer.singleton.user?.posFit!)!) { (result) in
                                    
                                                    let decoder = JSONDecoder()
                                                    let data = result?.data(using: .utf8)
                                                    do{
                                                        let e_o = try decoder.decode(Events_QuestionsInSpecificRadar.self, from: data!)
                                                        SingletonServer.singleton.saveEvents_QuestionsInSpecificRadarState(json: result!, e_q: e_o)
                                                        DispatchQueue.main.async {
                                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "data"), object: nil)
                                                            self.removeCircle(circle: self.oldCircle)
                                                            self.oldCircle = self.showCircle(coordinate: location, radius: self.raggio!)

                                                        }
                                                        
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
                                
                               
                            
                                
                            
                            //            MessageTableView.messageTableView.reloadData()
                            
                }
                count = count+1
                }
         count = 0
        
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
    
//    funzione per cambiare l'immagine del pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView()
        let image: UIImage = UIImage(named: "FOOD")!
        annotationView.image = image
        
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


