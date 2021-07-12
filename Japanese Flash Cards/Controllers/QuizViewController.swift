//
//  ViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/02.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: WhiteBorderButton!
    @IBOutlet weak var buttonB: WhiteBorderButton!
    @IBOutlet weak var buttonC: WhiteBorderButton!
    @IBOutlet weak var buttonD: WhiteBorderButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var questionNumber = 0
    var correctScore = 0 // refresh this value at the end of the quiz
    var wrongCount = 0 // refresh this value for next question
    var quiz: Quiz?
    let seeds = Seeds()
    var quizData = QuizData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quiz = seeds.seedData()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == quizData.n5[Int(quiz!.quizIndex)][questionNumber].correctAnswer {
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
        
        if isLastQuestion() {
            goToResultPage()
        }
    }
    
    @objc func goToNextQuestion() {
        wrongCount = 0
        if questionNumber >= (quizData.n5[Int(quiz!.quizIndex)].count) - 1 {
            questionNumber = 0
            correctScore = 0
        } else {
            questionNumber += 1
        }
        
        updateUI()
    }
    
    func isLastQuestion() -> Bool {
        if questionNumber >= (quizData.n5[Int(quiz!.quizIndex)].count) - 1 {
            return true
        }
        return false
    }
    
    func goToResultPage() {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func shuffleAnswers() {
        quizData.n5[Int(quiz!.quizIndex)][questionNumber].answers.shuffle()
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float((quizData.n5[Int(quiz!.quizIndex)].count))
    }

    func getResult() -> Int {
        return Int((Float(correctScore) / Float((quizData.n5[Int(quiz!.quizIndex)].count))) * 100)
    }
    
    func updateUI() {
        // Button styling
        buttonA.setConfig()
        buttonB.setConfig()
        buttonC.setConfig()
        buttonD.setConfig()
        
        // Update questions and answers
        questionLabel.text = quizData.n5[Int(quiz!.quizIndex)][questionNumber].text
        
        shuffleAnswers()
        buttonA.setTitle(quizData.n5[Int(quiz!.quizIndex)][questionNumber].answers[0], for: .normal)
        buttonB.setTitle(quizData.n5[Int(quiz!.quizIndex)][questionNumber].answers[1], for: .normal)
        buttonC.setTitle(quizData.n5[Int(quiz!.quizIndex)][questionNumber].answers[2], for: .normal)
        buttonD.setTitle(quizData.n5[Int(quiz!.quizIndex)][questionNumber].answers[3], for: .normal)
        
        // Progress Bar
        progressBar.progress = getProgress()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.resultValue = String(getResult())
            destinationVC.quiz = quiz
        }
    }
}
