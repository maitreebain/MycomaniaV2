//
//  ViewController.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 4/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    let mapView = MapView()
    
    override func loadView() {
        view = mapView
    }
    
    private let locationSession = CoreLocationSession()
    
    private var userTrackingButton: MKUserTrackingButton!
    
    private var isShowingNewAnnotations = false
    
    private var annotations = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search"
        
        mapView.mapView.showsUserLocation = true
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 30, width: 40, height: 40))
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView.mapView
        
    }


}

