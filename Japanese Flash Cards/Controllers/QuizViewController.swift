//
//  ViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/02.
//

import UIKit
import CoreData

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
    var questions: [Question]?
    var answers: [String]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("started loading")
        loadQuiz()
        print("loaded")
        questions = quiz?.questions?.allObjects as? [Question]
        print("questions are ready")
        updateUI()
        print("ui is ready")
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == questions![questionNumber].correctAnswer {
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
        if questionNumber >= questions!.count - 1 {
            questionNumber = 0
            correctScore = 0
        } else {
            questionNumber += 1
        }
        
        updateUI()
    }
    
    func isLastQuestion() -> Bool {
        if questionNumber >= questions!.count - 1 {
            return true
        }
        return false
    }
    
    func goToResultPage() {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func shuffleAnswers() {
        answers!.shuffle()
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float((questions!.count))
    }

    func getResult() -> Int {
        return Int((Float(correctScore) / Float((questions!.count))) * 100)
    }
    
    func loadQuiz() {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "quizIndex == %i", 0)
        
        do {
            quiz = try context.fetch(request)[0]
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func updateUI() {
        // Button styling
        buttonA.setConfig()
        buttonB.setConfig()
        buttonC.setConfig()
        buttonD.setConfig()
        
        // Update questions and answers
        questionLabel.text = questions![questionNumber].text
        
        answers = questions![questionNumber].answers
        
        shuffleAnswers()
        buttonA.setTitle(answers![0], for: .normal)
        buttonB.setTitle(answers![1], for: .normal)
        buttonC.setTitle(answers![2], for: .normal)
        buttonD.setTitle(answers![3], for: .normal)
        
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
