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
        
        resultLabel.text = "\(resultValue!)%"
        
        if Int(resultValue!)! >= 70 {
            quiz?.isSuccessful = true
        } else {
            quiz?.isSuccessful = false
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToLessonsMenu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLessonsMenu" && quiz?.isSuccessful == true {
            let destinationVC = segue.destination as! LessonsViewController
            destinationVC.isLessonSuccessful = true
        }
    }
}
