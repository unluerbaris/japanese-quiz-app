//
//  ViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/02.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    let quiz = [
        Question(text: "月", answers: ["つき","き","にち","に"], correctAnswer: "つき")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == quiz[0].correctAnswer {
            print("Correct")
        } else {
            print("Wrong")
        }
    }
    
    func updateUI() {
        buttonA.applyButtonDesign()
        buttonB.applyButtonDesign()
        buttonC.applyButtonDesign()
        buttonD.applyButtonDesign()
        questionLabel.text = quiz[0].text
        buttonA.setTitle(quiz[0].answers[0], for: .normal)
        buttonB.setTitle(quiz[0].answers[1], for: .normal)
        buttonC.setTitle(quiz[0].answers[2], for: .normal)
        buttonD.setTitle(quiz[0].answers[3], for: .normal)
    }
}

extension UIButton {
    func applyButtonDesign() {
        self.backgroundColor = #colorLiteral(red: 0.2263737917, green: 0.2461832166, blue: 0.2789179683, alpha: 1)
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.9318081737, green: 0.9319420457, blue: 0.9317788482, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.9318081737, green: 0.9319420457, blue: 0.9317788482, alpha: 1)
    }
}

