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
import AVFoundation

var player: AVAudioPlayer?

class QuestionViewController: UIViewController {
    
    var user = Auth.auth().currentUser
    var attempts = 2 // attempts per question
    @IBOutlet weak var dieBotRightButton: UIButton!
    @IBOutlet weak var dieBotLeftButton: UIButton!
    @IBOutlet weak var dieTopRightButton: UIButton!
    @IBOutlet weak var dieTopLeftButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var tryAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // plays sound
        playSound(word)
        
        // load question
        wordLabel.text = ("how many phonemes are in the word \(word)").uppercased()
        
        // load dice
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
    
    // if top left die is clicked
    @IBAction func dieTopLeft(_ sender: Any) {
        if (countTaskAnswer == 2) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }
 
    // if top right die is clicked
    @IBAction func dieTopRight(_ sender: Any) {
        if (countTaskAnswer == 3) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }

    // if bottom left die is clicked
    @IBAction func dieBottomLeft(_ sender: Any) {
        if (countTaskAnswer == 4) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }
   
    // if bottom right die is clicked
    @IBAction func dieBottomRight(_ sender: Any) {
        if (countTaskAnswer == 5) {
            correctTransition()
        } else {
            incorrectTransition()
        }
    }
    
    // reload page if try again is clicked
    @IBAction func tryAgain(_ sender: Any) {
        viewDidLoad()
    }
    
    // remove all dice and load try again button
    func incorrectTransition() {
        dieTopLeftButton.setBackgroundImage(nil, for: .normal)
        dieTopRightButton.setBackgroundImage(nil, for: .normal)
        dieBotLeftButton.setBackgroundImage(nil, for: .normal)
        dieBotRightButton.setBackgroundImage(nil, for: .normal)
        attempts -= 1
        if (attempts > 0) {
            tryAgainButton.alpha = 1
            playHint(word)
        } else {
            performSegue(withIdentifier: "countingFromQuestion", sender: self)
        }
    }
    
    // if answered correctly
    func correctTransition() {
        updateProgress(1)
        performSegue(withIdentifier: "toAnswer", sender: self)
    }
    
    // updates progress of user in firebase
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
    
    // plays sound for page
    func playSound(_ sound: String) -> Void {
        if let path = Bundle.main.path(forResource: sound, ofType: "MP3") {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player?.play()
                if player!.play() {
                    print(word)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // plays hint audio
    func playHint(_ sound: String) -> Void {
        // functionality to play hint audio
        let hint_sound = sound + "_hint"
        if let path = Bundle.main.path(forResource: hint_sound, ofType: "MP3") {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player?.play()
                if player!.play() {
                    print(word)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
