//
//  MapViewController.swift
//  myFirstARapp
//
//  Created by Vincenzo di Somma on 07/07/2019.
//  Copyright © 2019 Vincenzo di Somma. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var points:[PointOfInterest] = []
    
    var locationManager=CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate=self
        self.locationManager.requestWhenInUseAuthorization()
        map.showsUserLocation=true
        map.showsPointsOfInterest=true
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        loadInitialData()
        map.addAnnotations(points)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.map.setRegion(viewRegion, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addNewPoint":
            let poi=PointOfInterest(title: "", where: "", at: CLLocationCoordinate2D(latitude:(locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!))
            let dstview=segue.destination as! PointAddingViewController
            dstview.poi=poi
            map.addAnnotation(poi)
            map.addOverlay(MKCircle(center:CLLocationCoordinate2D(latitude:(locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!) , radius: 15))
            
        case "showPointDetail":
            let dstview=segue.destination as! PointDetailViewController
            dstview.poi=location
        default:
            print("lol")
        }
    }
    var location:PointOfInterest?
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        location=view.annotation as? PointOfInterest
        performSegue(withIdentifier: "showPointDetail", sender: self)
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? PointOfInterest else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func getZPosition(intel poi:CLLocation,you up:CLLocation) -> Double{  //Haversine formula
        let R:Double=6372.797560856
        
        let deltaLat=poi.coordinate.latitude*Double.pi/180 - up.coordinate.latitude*Double.pi/180
        let deltaLon=poi.coordinate.longitude*Double.pi/180 - up.coordinate.longitude*Double.pi/180
        
        let a=sin(deltaLat/2)*sin(deltaLat/2)+cos(poi.coordinate.latitude*Double.pi/180)*cos(up.coordinate.latitude*Double.pi/180) * sin(deltaLon/2)*sin(deltaLon/2)
        
        let c = 2*atan2(sqrt(a), sqrt(1-a))
        let d = R*c
        return d*1000
    }
    @objc func deleteAnnotation(_ notification: Notification) {
        map.removeAnnotation(location!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteAnnotation(_:)), name: Notification.Name(rawValue: "deleteAnnotation"), object: nil)
    }
    
    func loadInitialData() {
        // 1
        guard let fileName = Bundle.main.path(forResource: "Tutto", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            // 2
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3
            let dictionary = json as? [String: Any],
            // 4
            let works = dictionary["data"] as? [[Any]]
            else { return }
        // 5
        let validWorks = works.compactMap { PointOfInterest(json: $0) }
        points.append(contentsOf: validWorks)
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay=overlay as? MKCircle{
            let circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor=UIColor.blue
            circleRenderer.alpha=0.3
            circleRenderer.strokeColor=UIColor.black
            circleRenderer.lineWidth=2
            return circleRenderer
        }
        return MKCircleRenderer()
    }
}

