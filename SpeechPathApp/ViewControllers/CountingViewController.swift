//
//  CountingViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 11/22/19.
//  Copyright © 2019 Ishan Chadha. All rights reserved.
//

import UIKit

let countTaskArray = ["float", "turkey", "under", "creek", "candy", "book", "spider", "eyes", "mummy", "babble", "goat", "dinner", "message", "limit", "play", "horse", "free", "lunch", "jump", "rise", "throw", "mask", "shine", "spoon"]
var countTaskIndex = 0
var word = "null"

class CountingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var countingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countingTableView.delegate = self
        countingTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countTaskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countingCell", for: indexPath)
        
        cell.textLabel?.text = countTaskArray[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 200))
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1, alpha: 1)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countTaskIndex = indexPath.row
        word = countTaskArray[countTaskIndex]
        print(countTaskIndex)
        performSegue(withIdentifier: "toQuestion", sender: self)
    }
}
