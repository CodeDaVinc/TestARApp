//
//  MapSelectViewController.swift
//  myFirstARapp
//
//  Created by Vincenzo di Somma on 07/07/2019.
//  Copyright © 2019 Vincenzo di Somma. All rights reserved.
//

import UIKit
import MapKit

class MapSelectViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager=CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
    self.locationManager.requestWhenInUseAuthorization()
        map.showsUserLocation=true
        map.showsPointsOfInterest=true
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let userLocation = locations.last
        let viewRegion = MKCoordinateRegion(center: (userLocation?.coordinate)!, latitudinalMeters: 600, longitudinalMeters: 600)
        self.map.setRegion(viewRegion, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func addNewPoint(_ sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began {
            return
        }
        let touchLocation = sender.location(in: view)
        let locationCoordinate=map.convert(touchLocation, toCoordinateFrom: self.view)
        let poi=PointOfInterest(title: "test", where: "test", at: CLLocationCoordinate2D(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude))
        map.addAnnotation(poi)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
