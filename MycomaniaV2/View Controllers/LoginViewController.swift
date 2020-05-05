//
//  LoginViewController.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 4/30/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth

enum accountState {
    case newUser
    case existingUser
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var loginButton: DesignableButton!
    @IBOutlet weak var signInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        introUI()
    }
    
    private func introUI() {
        loginButton.borderColor = #colorLiteral(red: 0.06649553031, green: 0.09702528268, blue: 0.4052153826, alpha: 0.7868418236)
    }
    
    private func navigateToMap() {
        let mapView = MapViewController()
        UIViewController.showViewController(viewController: mapView)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        
    }
    
    private func logInFlow() {
        
    }
    
}
