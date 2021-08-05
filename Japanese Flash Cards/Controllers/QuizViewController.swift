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
    
    var quizIndex: Int64?
    var questionNumber = 0
    var correctScore = 0 // refresh this value at the end of the quiz
    var wrongCount = 0 // refresh this value for the next question
    var quiz: Quiz?
    var questions: [Question]?
    var answers: [String]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuiz()
        questions = quiz?.questions?.allObjects as? [Question]
        updateUI()
    }
    
    //MARK: - Button Actions
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == questions![questionNumber].correctAnswer {
            if wrongCount == 0 {
                correctScore += 1
            }
            sender.alpha = 0.8
            sender.backgroundColor = #colorLiteral(red: 0.5617800355, green: 0.7589344978, blue: 0.5799990296, alpha: 0.9011945914)
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
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
    
    //MARK: - Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.resultValue = String(getResult())
            destinationVC.quiz = quiz
        }
    }
    
    func goToResultPage() {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    //MARK: - Read Data
    
    func loadQuiz() {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "quizIndex == %i", quizIndex!)
        
        do {
            quiz = try context.fetch(request)[0]
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    //MARK: - Quiz Logic
    
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
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float((questions!.count))
    }

    func getResult() -> Int {
        return Int((Float(correctScore) / Float((questions!.count))) * 100)
    }
    
    func shuffleAnswers() {
        answers!.shuffle()
    }
    
    //MARK: - Generate UI
    
    func updateUI() {
        // Reset button styling
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
}
