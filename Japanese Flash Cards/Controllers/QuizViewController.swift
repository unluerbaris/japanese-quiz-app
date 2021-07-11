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
    var questionsArray = [Question]()
    var lesson: Lesson?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let questionsFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let questionsDeleteRequest = NSBatchDeleteRequest(fetchRequest: questionsFetchRequest)

        do {
            try persistentStoreCoordinator.execute(questionsDeleteRequest, with: context)
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
        
        let lessonsFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let lessonsDeleteRequest = NSBatchDeleteRequest(fetchRequest: lessonsFetchRequest)

        do {
            try persistentStoreCoordinator.execute(lessonsDeleteRequest, with: context)
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
        
        // save them somewhere else
        let question1 = Question(context: context)
        question1.text = "月"
        question1.answers = ["つき","き","にち","に"]
        question1.correctAnswer = "つき"
        let question2 = Question(context: context)
        question2.text = "日"
        question2.answers = ["き","ひ","ち","は"]
        question2.correctAnswer = "ひ"
        questionsArray.append(question1)
        questionsArray.append(question2)
        lesson = Lesson(context: context)
        lesson?.isSuccessful = false
        lesson?.lessonIndex = 0
        lesson?.quiz = questionsArray
        
        saveLesson()
        loadLesson()
        updateUI()
    }
    
    func saveLesson() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadLesson() {
        let request : NSFetchRequest<Question> = Question.fetchRequest()
        do {
            questionsArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        if sender.currentTitle! == questionsArray[questionNumber].correctAnswer {
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
        if questionNumber >= questionsArray.count - 1 {
            questionNumber = 0
            correctScore = 0
        } else {
            questionNumber += 1
        }
        
        updateUI()
    }
    
    func isLastQuestion() -> Bool {
        if questionNumber >= questionsArray.count - 1 {
            return true
        }
        return false
    }
    
    func goToResultPage() {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func shuffleAnswers() {
        questionsArray[questionNumber].answers?.shuffle()
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(questionsArray.count)
    }

    func getResult() -> Int {
        return Int((Float(correctScore) / Float(questionsArray.count)) * 100)
    }
    
    func updateUI() {
        // Button styling
        buttonA.setConfig()
        buttonB.setConfig()
        buttonC.setConfig()
        buttonD.setConfig()
        
        // Update questions and answers
        questionLabel.text = questionsArray[questionNumber].text
        
        shuffleAnswers()
        buttonA.setTitle(questionsArray[questionNumber].answers?[0], for: .normal)
        buttonB.setTitle(questionsArray[questionNumber].answers?[1], for: .normal)
        buttonC.setTitle(questionsArray[questionNumber].answers?[2], for: .normal)
        buttonD.setTitle(questionsArray[questionNumber].answers?[3], for: .normal)
        
        // Progress Bar
        progressBar.progress = getProgress()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.resultValue = String(getResult())
            destinationVC.lesson = lesson
        }
    }
}
