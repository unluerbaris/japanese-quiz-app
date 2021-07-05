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
    
    var quiz = [
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
            sender.backgroundColor = #colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1)
        } else {
            sender.backgroundColor = #colorLiteral(red: 0.7846533656, green: 0.2946209013, blue: 0.194943279, alpha: 1)
        }
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(goToNextQuestion), userInfo: nil, repeats: false)
    }
    
    func shuffleAnswers() {
        quiz[questionNumber].answers.shuffle()
    }
    
    @objc func goToNextQuestion() {
        if questionNumber >= quiz.count - 1 {
            questionNumber = 0
        } else {
            questionNumber += 1
        }
        updateUI()
    }
    
    func updateUI() {
        // Button styling
        buttonA.applyButtonDesign()
        buttonB.applyButtonDesign()
        buttonC.applyButtonDesign()
        buttonD.applyButtonDesign()
        
        // Update questions and answers
        questionLabel.text = quiz[questionNumber].text
        
        shuffleAnswers()
        buttonA.setTitle(quiz[questionNumber].answers[0], for: .normal)
        buttonB.setTitle(quiz[questionNumber].answers[1], for: .normal)
        buttonC.setTitle(quiz[questionNumber].answers[2], for: .normal)
        buttonD.setTitle(quiz[questionNumber].answers[3], for: .normal)
    }
}

extension UIButton {
    func applyButtonDesign() {
        self.backgroundColor = #colorLiteral(red: 0.09018556029, green: 0.09020196646, blue: 0.09017995745, alpha: 1)
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.9230592251, green: 0.8625263572, blue: 0.7306218743, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.9230592251, green: 0.8625263572, blue: 0.7306218743, alpha: 1)
    }
}
