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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
