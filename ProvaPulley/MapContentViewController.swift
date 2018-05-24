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

class MapContentViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

   

    @IBAction func pos(_ sender: Any) {
        manager.startUpdatingLocation()
    }
    
  
    
    @IBOutlet weak var mappe: MKMapView!
    
    let manager = CLLocationManager()
    
    
    
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
        
        print(location.altitude)
        
//        questa riga mi miostra il pallino blu sulla mappa
        self.mappe.showsUserLocation = true
        manager.stopUpdatingLocation()
        
        let marker = MKPointAnnotation()

        marker.coordinate = myLocation
        marker.title = "SI STRUNZ"
        
        mappe.addAnnotation(marker)
        
    }
    
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
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView()
        annotationView.image = UIImage(named: "arrow2")
//        let transform = CGAffineTransform(scaleX: 10, y: 10)
//        annotationView.transform = transform
        return annotationView
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
