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
    @IBOutlet weak var progressBar: UIProgressView!
    
    var quiz = [
        Question(text: "月", answers: ["つき","き","にち","に"], correctAnswer: "つき"),
        Question(text: "日", answers: ["き","ひ","ち","は"], correctAnswer: "ひ"),
        Question(text: "人", answers: ["ひと","き","つき","ひげ"], correctAnswer: "ひと")
    ]
    
    var questionNumber = 0
    var correctScore = 0 // refresh this value at the end of the quiz
    var wrongCount = 0 // refresh this value for next question
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == quiz[questionNumber].correctAnswer {
            if wrongCount == 0 {
                correctScore += 1
            }
            sender.alpha = 0.8
            sender.backgroundColor = #colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1)
        } else {
            wrongCount += 1
            sender.isEnabled = false
            sender.alpha = 0.3
            return
        }
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(goToNextQuestion), userInfo: nil, repeats: false)
    }
    
    func shuffleAnswers() {
        quiz[questionNumber].answers.shuffle()
    }
    
    @objc func goToNextQuestion() {
        wrongCount = 0
        
        if questionNumber >= quiz.count - 1 {
            questionNumber = 0
            print(getResult())
            correctScore = 0
        } else {
            questionNumber += 1
        }
        updateUI()
    }
    
    func getResult() -> Int {
        return Int((Float(correctScore) / Float(quiz.count)) * 100)
    }
    
    func updateUI() {
        // Button styling
        buttonA.applyButtonConfigs()
        buttonB.applyButtonConfigs()
        buttonC.applyButtonConfigs()
        buttonD.applyButtonConfigs()
        
        // Update questions and answers
        questionLabel.text = quiz[questionNumber].text
        
        shuffleAnswers()
        buttonA.setTitle(quiz[questionNumber].answers[0], for: .normal)
        buttonB.setTitle(quiz[questionNumber].answers[1], for: .normal)
        buttonC.setTitle(quiz[questionNumber].answers[2], for: .normal)
        buttonD.setTitle(quiz[questionNumber].answers[3], for: .normal)
        
        // Progress Bar
        progressBar.progress = Float(questionNumber) / Float(quiz.count)
    }
}

extension UIButton {
    func applyButtonConfigs() {
        self.isEnabled = true
        self.alpha = 1.0
        self.backgroundColor = #colorLiteral(red: 0.09018556029, green: 0.09020196646, blue: 0.09017995745, alpha: 1)
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.9230592251, green: 0.8625263572, blue: 0.7306218743, alpha: 1)
        self.tintColor = #colorLiteral(red: 0.9230945706, green: 0.862467885, blue: 0.7350425124, alpha: 1)
    }
}
