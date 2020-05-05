//
//  ViewController.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 4/7/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    let mapView = MapView()
    
    override func loadView() {
        view = mapView
    }
    
    private let locationSession = CoreLocationSession()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

