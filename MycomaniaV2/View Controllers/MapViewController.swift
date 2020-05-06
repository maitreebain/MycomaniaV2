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
    private var selectedAnnotation: MKPointAnnotation?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(handleLongPress(_:)))
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Search"
        longPressGesture.minimumPressDuration = 0.5
        loadMapView()
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: mapView.mapView.userLocation.coordinate, span: span)
//        mapView.mapView.setRegion(region, animated: true)
    }
    
    private func loadMapView() {
        mapView.mapView.delegate = self
        mapView.mapView.showsUserLocation = true
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 30, width: 40, height: 40))
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView.mapView
        mapView.addGestureRecognizer(longPressGesture)
        
    }
    
    @objc private func handleLongPress(_ sender: UILongPressGestureRecognizer){
        let map = mapView.mapView
        let location = sender.location(in: map)
        let coordinate = map.convert(location, toCoordinateFrom: map)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        //maybe have a view pop up to where user can edit title?
        annotation.title = "user input title"
        annotation.subtitle = "subtitle"
        map.addAnnotation(annotation)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let latTitle: String = String(format: "%.02f", Float((view.annotation?.coordinate.latitude)!))
        let longTitle: String = String(format: "%.02f", Float((view.annotation?.coordinate.longitude)!))
        
        print(latTitle + longTitle)
    }
    
}
