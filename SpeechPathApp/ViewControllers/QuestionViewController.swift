//
//  QuestionViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 11/22/19.
//  Copyright © 2019 Ishan Chadha. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class QuestionViewController: UIViewController {
    
    var user = Auth.auth().currentUser
    @IBOutlet weak var dieBotRightButton: UIButton!
    @IBOutlet weak var dieBotLeftButton: UIButton!
    @IBOutlet weak var dieTopRightButton: UIButton!
    @IBOutlet weak var dieTopLeftButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var tryAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabel.text = ("how many phonemes are in the word \(word)").uppercased()
        let image1 = UIImage(named: "Dice2@2x.png") as UIImage?
        let button1   = dieTopLeftButton!
        button1.setBackgroundImage(image1, for: UIControl.State.normal)
        let image2 = UIImage(named: "Dice3@2x.png") as UIImage?
        let button2   = dieTopRightButton!
        button2.setBackgroundImage(image2, for: UIControl.State.normal)
        let image3 = UIImage(named: "Dice4@2x.png") as UIImage?
        let button3   = dieBotLeftButton!
        button3.setBackgroundImage(image3, for: UIControl.State.normal)
        let image4 = UIImage(named: "Dice5@2x.png") as UIImage?
        let button4   = dieBotRightButton!
        button4.setBackgroundImage(image4, for: UIControl.State.normal)
        tryAgainButton.alpha = 0
    }
    
    @IBAction func dieTopLeft(_ sender: Any) {
        if (countTaskAnswer == 2) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }
    
    @IBAction func dieTopRight(_ sender: Any) {
        if (countTaskAnswer == 3) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }
    
    @IBAction func dieBottomLeft(_ sender: Any) {
        if (countTaskAnswer == 4) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }
    
    @IBAction func dieBottomRight(_ sender: Any) {
        if (countTaskAnswer == 5) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        viewDidLoad()
    }
    
    func incorrectTransition() {
        dieTopLeftButton.setBackgroundImage(nil, for: .normal)
        dieTopRightButton.setBackgroundImage(nil, for: .normal)
        dieBotLeftButton.setBackgroundImage(nil, for: .normal)
        dieBotRightButton.setBackgroundImage(nil, for: .normal)
        tryAgainButton.alpha = 1
    }
    
    func correctTransition() {
        updateProgress(1)
        performSegue(withIdentifier: "toAnswer", sender: self)
    }
    
    func updateProgress(_ num: Int) -> Void {
        let userID = Auth.auth().currentUser?.uid
        var update = num as NSNumber
        var newArr = [String]()
        Firestore.firestore().collection("users").document(userID!).getDocument { (document, error) in
            if let document = document {
                let progress = document["moduleprogress"] as! NSNumber
                let arr = document["progressarray"] as! NSArray
                if !arr.contains("\(word)") {
                    update = update.intValue + progress.intValue as NSNumber
                    let cArr = NSMutableArray(array: arr)
                    if let swiftArr = cArr as NSArray as? [String] {
                        newArr = swiftArr
                        newArr.append(contentsOf: ["\(word)"])
                    }
                    Firestore.firestore().collection("users").document(userID!).setData(["moduleprogress": update])
                    Firestore.firestore().collection("users").document(userID!).updateData(["progressarray": FieldValue.arrayUnion((newArr as NSArray) as! [Any])])
                }
            }
        }
    }
}
