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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "\(resultValue ?? "No Value")%"
        
        if Int(resultValue ?? "0")! >= 70 {
            quiz?.isSuccessful = true
        } else {
            quiz?.isSuccessful = false
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToLessonsMenu", sender: self)
    }
}
