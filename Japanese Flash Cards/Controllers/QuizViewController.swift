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
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if quizBrain.checkAnswer(sender.currentTitle!) {
            if quizBrain.getWrongAnswerCount() == 0 {
                quizBrain.increaseScore()
            }
            sender.alpha = 0.8
            sender.backgroundColor = #colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1)
        } else {
            quizBrain.increaseWrongAnswerCount()
            sender.isEnabled = false
            sender.alpha = 0.3
            return
        }
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(goToNextQuestion), userInfo: nil, repeats: false)
        
        if quizBrain.isLastQuestion() {
            goToResultPage()
        }
    }
    
    @objc func goToNextQuestion() {
        quizBrain.getNextQuestion()
        updateUI()
    }
    
    func goToResultPage() {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func updateUI() {
        // Button styling
        buttonA.setConfig()
        buttonB.setConfig()
        buttonC.setConfig()
        buttonD.setConfig()
        
        // Update questions and answers
        questionLabel.text = quizBrain.getQuestionText()
        
        quizBrain.shuffleAnswers()
        buttonA.setTitle(quizBrain.getAnswerButtonText(index: 0), for: .normal)
        buttonB.setTitle(quizBrain.getAnswerButtonText(index: 1), for: .normal)
        buttonC.setTitle(quizBrain.getAnswerButtonText(index: 2), for: .normal)
        buttonD.setTitle(quizBrain.getAnswerButtonText(index: 3), for: .normal)
        
        // Progress Bar
        progressBar.progress = quizBrain.getProgress()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.resultValue = String(quizBrain.getResult())
        }
    }
}
