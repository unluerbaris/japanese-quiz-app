//
//  ResultViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/06.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var resultValue: String?
    var quiz: Quiz?
    let seeds = Seeds()
    var barColor: CGColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Int(resultValue ?? "0")! >= 70 {
            quiz?.isSuccessful = true
            infoLabel.text = "PASSED"
            infoLabel.textColor = UIColor.systemTeal
            barColor = UIColor.cyan.cgColor
            seeds.saveData()
        } else {
            quiz?.isSuccessful = false
            infoLabel.text = "FAIL"
            infoLabel.textColor = UIColor.red
            barColor = UIColor.red.cgColor
            seeds.saveData()
        }
        
        // TODO create empty view instead of result layer
        _ = CircularProgressBar(
                barRadius: CGFloat(80),
                lineWidth: CGFloat(15),
                xPos: progressBarView.center.x - 20,
                yPos: progressBarView.center.y - 70,
                color: barColor!,
                textSize: 60,
                animationDuration: CGFloat(2 * (Double(resultValue ?? "0")! / 100)),
                progressAmount: CGFloat((Double(resultValue ?? "0")! / 100)),
                selectedView: view
        )
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "goToLessonsMenu", sender: self)
    }
}
