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
    
    let manager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mappe.delegate = self
        manager.delegate = self
        
//        per ottenere la miglior location dell'user
        manager.desiredAccuracy = kCLLocationAccuracyBest
   
//        richiede l'autorizzazione
    manager.requestWhenInUseAuthorization()
//        chiede al manager di aggiornare la posizione
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        
        
        
       
        
        print("ci arrivo")
    }
    

    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: coordinate, radius: radius)
        mappe.add(circle)
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
        
        showCircle(coordinate: myLocation, radius: CLLocationDistance(exactly: 10000)!)
        print(location.altitude)
        
        //        questa riga mi miostra il pallino blu sulla mappa
        self.mappe.showsUserLocation = true
        manager.stopUpdatingLocation()
        
        let marker = MKPointAnnotation()
        
        marker.coordinate = myLocation
        marker.title = "SI STRUNZ"
        
        mappe.addAnnotation(marker)
        
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


