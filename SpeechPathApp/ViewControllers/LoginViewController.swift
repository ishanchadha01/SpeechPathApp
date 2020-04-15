//
//  LoginViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 10/26/19.
//  Copyright © 2019 Ishan Chadha. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var
        loginButton:
        UIButton!
    @IBOutlet weak var
        errorLabel:
        UILabel!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    // creates page for login with formatting
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleFilledButton(backButton)
    }
    
    // updates database and authentication to allow user in
    @IBAction func loginButtonTapped(_ sender: Any) {
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.transitionToHome()
            }
        }
    }
    
    // shows different error messages based on what's passed in
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    // sets home page as root view once logged in
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

    @IBAction func forgotPasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "toForgotPassword", sender: self)
    }
}
