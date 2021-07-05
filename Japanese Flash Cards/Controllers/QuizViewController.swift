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
        Question(text: "月", answers: ["つき","き","にち","に"], correctAnswer: "つき"),
        Question(text: "日", answers: ["き","ひ","ち","は"], correctAnswer: "ひ"),
        Question(text: "人", answers: ["ひと","き","つき","ひげ"], correctAnswer: "ひと")
    ]
    
    var questionNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == quiz[questionNumber].correctAnswer {
            print("Correct")
        } else {
            print("Wrong")
        }
        goToNextQuestion()
    }
    
    func goToNextQuestion() {
        if questionNumber >= quiz.count - 1 {
            questionNumber = 0
        } else {
            questionNumber += 1
        }
        updateUI()
    }
    
    func updateUI() {
        buttonA.applyButtonDesign()
        buttonB.applyButtonDesign()
        buttonC.applyButtonDesign()
        buttonD.applyButtonDesign()
        questionLabel.text = quiz[questionNumber].text
        buttonA.setTitle(quiz[questionNumber].answers[0], for: .normal)
        buttonB.setTitle(quiz[questionNumber].answers[1], for: .normal)
        buttonC.setTitle(quiz[questionNumber].answers[2], for: .normal)
        buttonD.setTitle(quiz[questionNumber].answers[3], for: .normal)
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

