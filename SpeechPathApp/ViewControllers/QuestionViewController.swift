//
//  QuestionViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 11/22/19.
//  Copyright © 2019 Ishan Chadha. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var dieBotRightButton: UIButton!
    @IBOutlet weak var dieBotLeftButton: UIButton!
    @IBOutlet weak var dieTopRightButton: UIButton!
    @IBOutlet weak var dieTopLeftButton: UIButton!
    @IBOutlet weak var wordLabel: UILabel!
    
    
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
    }
    
    @IBAction func dieTopLeft(_ sender: Any) {
    }
    
    @IBAction func dieTopRight(_ sender: Any) {
    }
    
    @IBAction func dieBottomLeft(_ sender: Any) {
    }
    
    @IBAction func dieBottomRight(_ sender: Any) {
    }
}
