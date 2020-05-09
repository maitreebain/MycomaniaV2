//
//  LoginViewController.swift
//  MycomaniaV2
//
//  Created by Maitree Bain on 4/30/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

enum AccountState {
    case newUser
    case existingUser
}

class LoginViewController: UIViewController, GIDSignInDelegate {

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
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
    
    private func navToTab() {
        let tabController = TabBarViewController()
        UIViewController.showViewController(viewController: tabController)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
     print("did sign in with google")
        if let error = error {
            print("failed to sign in: \(error.localizedDescription)")
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authDataResult, error) in
            
            if let error = error {
                print("failed to retrieve data: \(error.localizedDescription)")
            }
            
            guard let authResult = authDataResult else { return }
            
            DatabaseService.shared.createDatabaseUser(authDataResult: authResult) { (result) in
                
                switch result{
                case .failure(let error):
                    print("could not create user with google: \(error.localizedDescription)")
                case .success:
                    print("created account with google")
                    self.dismiss(animated: true)
                }
            }
            self.navToTab()
        }
    }
    
    
    @IBAction func googleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    
    func fbLogin() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions:[ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            
            switch loginResult {
            
            case .failed(let error):
                print(error)
            
            case .cancelled:
                print("User cancelled login process.")
            
            case .success( _, _, _):
                self.getFBUserData()
            }
        }
    }
    
    func getFBUserData() {
        if((AccessToken.current) != nil){
            
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    let dict = result as! [String : AnyObject]
                    print(result!)
                    print(dict)
//                    let picutreDic = dict as NSDictionary
//                    if let emailAddress = picutreDic.object(forKey: "email") {
//
//                    }
//
//                    else {
//                        print("could not sign in w fb account")
//                    }
                    
                   
                }
                self.navToTab()
                print(error?.localizedDescription as Any)
            })
        }
    }
    
    @IBAction func facebookSignIn(_ sender: UIButton) {
        fbLogin()
        //does not create fb user yet
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

