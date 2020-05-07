//
//  ResetPasswordViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 4/14/20.
//  Copyright © 2020 Ishan Chadha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.textColor = UIColor.red
        errorLabel.alpha = 0
    }

    @IBAction func sendEmailTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else {
            self.showError("Enter valid email")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                self.errorLabel.textColor = UIColor.white
                self.showError("Email sent!")
                self.logoutUser()
            } else {
                self.showError("Error sending email")
            }
        }
        logoutUser()
    }
    
    // shows different error messages based on what's passed in
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    // log out user
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }
}
