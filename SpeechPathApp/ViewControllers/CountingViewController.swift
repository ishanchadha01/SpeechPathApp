//
//  CountingViewController.swift
//  SpeechPathApp
//
//  Created by Ishan Chadha on 11/22/19.
//  Copyright © 2019 Ishan Chadha. All rights reserved.
//

import UIKit

let countTaskArray = [["float", 4], ["turkey", 4], ["under", 4], ["creek", 4], ["candy", 5], ["book", 3], ["spider", 5], ["eyes", 2], ["mummy", 4], ["babble", 4], ["goat", 3], ["dinner", 4], ["message", 5], ["limit", 5], ["play", 3], ["horse", 3], ["free", 3], ["lunch", 4], ["jump", 4], ["rise", 3], ["throw", 3], ["mask", 4], ["shine", 3], ["spoon", 4]]
var countTaskIndex = 0
var countTaskAnswer = 0
var word = ""

class CountingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var countingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countingTableView.delegate = self
        countingTableView.dataSource = self
    }
    
    // table length equals number of tasks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countTaskArray.count
    }
    
    // creates table of tasks
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countingCell", for: indexPath)
        
        cell.textLabel?.text = countTaskArray[indexPath.row][0] as? String
        cell.textLabel?.font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight(rawValue: 200))
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1, alpha: 1)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    // moves to question page based on which task is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countTaskIndex = indexPath.row
        word = countTaskArray[countTaskIndex][0] as! String
        countTaskAnswer = countTaskArray[countTaskIndex][1] as! IntegerLiteralType
        performSegue(withIdentifier: "toQuestion", sender: self)
    }
}
