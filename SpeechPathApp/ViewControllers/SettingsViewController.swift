//
//  SettingsViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 11/15/19.
//  Copyright © 2019 Ishan Chadha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // logs out user and deauthenticates with firebase
    @IBAction func logoutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
    }
    
    @IBAction func changePasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "toResetPassword", sender: self)
    }
}
