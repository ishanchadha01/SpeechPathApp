//
//  AnswerViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 2/17/20.
//  Copyright © 2020 Ishan Chadha. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var phonemes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image1 = UIImage(named: "\(word).png") as UIImage?
        phonemes.setBackgroundImage(image1, for: .normal)
    }
}
