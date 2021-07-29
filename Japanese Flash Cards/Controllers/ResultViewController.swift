//
//  ResultViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/06.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var resultValue: String?
    var quiz: Quiz?
    let seeds = Seeds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "\(resultValue ?? "No Value")%"
        
        if Int(resultValue ?? "0")! >= 70 {
            quiz?.isSuccessful = true
            seeds.saveData()
        } else {
            quiz?.isSuccessful = false
            seeds.saveData()
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToLessonsMenu", sender: self)
    }
}
