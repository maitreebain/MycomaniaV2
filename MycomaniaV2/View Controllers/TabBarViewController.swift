//
//  TabBarViewController.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 4/29/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private lazy var mapViewController: MapViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MapViewController") as MapViewController
        viewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "mappin.and.ellipse"), tag: 0)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [UINavigationController(rootViewController: mapViewController)]
    }


}
