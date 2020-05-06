//
//  ShroomClass.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 5/5/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//might use this
class ShroomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}

//viewdidload code
/*
 mapView.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
 
 
 */
