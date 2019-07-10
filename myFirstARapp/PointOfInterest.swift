//
//  PointOfInterest.swift
//  myFirstARapp
//
//  Created by Vincenzo di Somma on 07/07/2019.
//  Copyright © 2019 Vincenzo di Somma. All rights reserved.
//

import UIKit
import MapKit

class PointOfInterest: NSObject,MKAnnotation {
    
    var title: String?
    var locationName: String
    var coordinate: CLLocationCoordinate2D
//    var type: String?
    
    init(title:String,where locationName:String,at coordinate:CLLocationCoordinate2D) {
        self.title=title
        self.locationName=locationName
        self.coordinate=coordinate
        
        super.init()
    }
    var subtitle: String?{
        return locationName
    }
    
    init?(json: [Any]) {
        self.title = json[16] as? String ?? "No Title"
        self.locationName = json[12] as! String
        if let latitude = Double(json[18] as! String),
            let longitude = Double(json[19] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
}
