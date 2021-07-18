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
            seeds.saveQuiz()
        } else {
            quiz?.isSuccessful = false
            seeds.saveQuiz() // this line might be deleted in the future
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToLessonsMenu", sender: self)
    }
}
