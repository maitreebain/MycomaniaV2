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
        let viewController = MapViewController()
        viewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "mappin.and.ellipse"), tag: 0)
        return viewController
    }()
    
    private lazy var feedViewController: FeedViewController = {
       let viewController = FeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "square.grid.4x3.fill"), tag: 1)
        return viewController
    }()

    //make prof view controller a storyboard
    private lazy var profileViewController: ProfileViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ProfileViewController") as ProfileViewController
        viewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 2)
        return viewController
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            UINavigationController(rootViewController: mapViewController),
            UINavigationController(rootViewController: feedViewController),
            profileViewController
        ]
    }


}
