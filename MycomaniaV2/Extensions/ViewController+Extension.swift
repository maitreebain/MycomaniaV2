//
//  ViewController+Extension.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 5/4/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private static func resetWindow(_ rootViewController: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first,
            let sceneDelegate = scene.delegate as? SceneDelegate,
            let window = sceneDelegate.window else {
                fatalError("could not reset window rootViewController")
        }
        window.rootViewController = rootViewController
    }
    
    public static func showViewController(storyboardName: String, viewControllerID: String) {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        resetWindow(newVC)
    }
    
    public static func showViewController(viewController: UIViewController) {
        resetWindow(viewController)
    }
}

extension UIViewController {
    public func showAlert(title: String?, message: String?) {
        let alertController  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
