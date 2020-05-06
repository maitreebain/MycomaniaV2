//
//  MapView.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 5/4/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    
    public lazy var citySearch: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Enter a city"
        search.layer.cornerRadius = 10
        search.layer.masksToBounds = true
        return search
    }()
    
    public lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsCompass = true
        map.mapType = .standard
        return map
    }()
    
    //switch map types
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpMapViewConstraints()
        setUpCitySearchConstraints()
    }
    
    private func setUpMapViewConstraints() {
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpCitySearchConstraints() {
        addSubview(citySearch)
        
        citySearch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            citySearch.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            citySearch.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            citySearch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

}
