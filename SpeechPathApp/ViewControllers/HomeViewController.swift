//
//  HomeViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 10/26/19.
//  Copyright © 2019 Ishan Chadha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

let moduleArray = ["counting", "blending", "segmenting", "manipulating"]
var myIndex = 0

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user = Auth.auth().currentUser
    @IBOutlet weak var Welcome: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printFirstName(self.Welcome)
        homeTableView.dataSource = self
        homeTableView.delegate = self
        updateProgressBar()
    }
    
    // updates progress bar by reading progress from firebase
    func updateProgressBar() -> Void {
        let userID = Auth.auth().currentUser?.uid
        Firestore.firestore().collection("users").document(userID!).getDocument { (document, error) in
            if let document = document {
                let progress = document["moduleprogress"]
                self.progressBar.setProgress(((progress as! Float) / 24.0), animated: false)
            }
        }
    }
    
    // prints first name of user by taking snapshot from firebase
    func printFirstName(_ label: UILabel) -> Void {
        let db = Firestore.firestore()
        db.collection("users").document(user!.email!)
        .addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
            return
          }
          guard let data = document.data() else {
            return
          }
            if let name = data["firstname"] as? String {
                label.text = "\(label.text!), \(name)"
            }
        }
    }
    
    // gives number of sections in module table
    func numberOfSections(in tableView: UITableView) -> Int {
        return moduleArray.count
    }
    
    // creates table view for modules
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // formatting and table view for modules
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
        cell.textLabel?.text = (moduleArray[indexPath.row]).uppercased()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 200))
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1, alpha: 1)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
    }
    
    // goes to selected module
    // only counting module has been created
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        if myIndex == 0 {
            performSegue(withIdentifier: "toCounting", sender: self)
        }
    }

}
