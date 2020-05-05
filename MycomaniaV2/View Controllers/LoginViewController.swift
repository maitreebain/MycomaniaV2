//
//  LoginViewController.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 4/30/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth

enum AccountState {
    case newUser
    case existingUser
}

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: DesignableTextField!
    @IBOutlet weak var passwordText: DesignableTextField!
    @IBOutlet weak var loginButton: DesignableButton!
    @IBOutlet weak var signInLabel: UILabel!
    
    var accountState = AccountState.existingUser
    
    private var authSession = AuthenticationSession()
    
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
        
        guard let email = emailText.text, !email.isEmpty, let password = passwordText.text, !password.isEmpty else {            DispatchQueue.main.async {
             self.showAlert(title: "Missing Fields", message: "Please enter your e-mail/password")
            }
            return }
        
        logInFlow(email: email, password: password)
        
    }
    
    private func logInFlow(email: String, password: String) {
        
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
                
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: "error logging in: \(error.localizedDescription)")
                    }
                case .success:
                    self?.navigateToMap()
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { [weak self] (result) in
                
                switch result{
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Error", message: "error signing up: \(error.localizedDescription)")
                    }
                case .success:
                    self?.navigateToMap()
                }
            }
            
        }
    }
    
    @IBAction func toggleButtonPressed(_ sender: UIButton) {
        
        accountState = accountState == .existingUser ? .newUser : .existingUser
        
        let duration: TimeInterval = 0.8
        
        if accountState == .existingUser {
            UIView.transition(with: self.view, duration: duration, options: [.transitionCrossDissolve], animations: {
                self.loginButton.setTitle("Login", for: .normal)
                self.signInLabel.text = "Don't have an account?"
            }, completion: nil)
        } else {
            UIView.transition(with: self.view, duration: duration, options: [.transitionCrossDissolve], animations: {
                self.loginButton.setTitle("Sign up", for: .normal)
                self.signInLabel.text = "Already have an account?"
            }, completion: nil)
        }
    }
}
