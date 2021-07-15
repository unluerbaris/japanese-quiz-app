//
//  Seeds.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/11.
//

import UIKit
import CoreData

class Seeds {
    
    var quizArray: [Quiz]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
    
    func seedData() {
//        let quizFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Quiz")
//        let quizDeleteRequest = NSBatchDeleteRequest(fetchRequest: quizFetchRequest)
//
//        do {
//            try persistentStoreCoordinator.execute(quizDeleteRequest, with: context)
//        } catch let error as NSError {
//            print("Data removing error \(error)")
//        }
//
//        let questionFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
//        let questionDeleteRequest = NSBatchDeleteRequest(fetchRequest: questionFetchRequest)
//
//        do {
//            try persistentStoreCoordinator.execute(questionDeleteRequest, with: context)
//        } catch let error as NSError {
//            print("Data removing error \(error)")
//        }
//
//        let question0 = Question(context: context)
//        question0.text = "月"
//        question0.answers = ["つき","き","にち","に"]
//        question0.correctAnswer = "つき"
//
//        let question1 = Question(context: context)
//        question1.text = "日"
//        question1.answers = ["き","ひ","ち","は"]
//        question1.correctAnswer = "ひ"
//
//        let question2 = Question(context: context)
//        question2.text = "人"
//        question2.answers = ["ひと","き","つき","ひげ"]
//        question2.correctAnswer = "ひと"
//
//        let quiz0 = Quiz(context: context)
//        quiz0.isSuccessful = false
//        quiz0.quizIndex = 0
//        quiz0.addToQuestions(question0)
//        quiz0.addToQuestions(question1)
//        quiz0.addToQuestions(question2)
//
//        saveQuiz()
        
//        for quiz in quizArray! {
//
//            let question0 = Question(context: context)
//            question0.text = "月"
//            question0.answers = ["つき","き","にち","に"]
//            question0.correctAnswer = "つき"
//
//            let question1 = Question(context: context)
//            question1.text = "日"
//            question1.answers = ["き","ひ","ち","は"]
//            question1.correctAnswer = "ひ"
//
//            let question2 = Question(context: context)
//            question2.text = "人"
//            question2.answers = ["ひと","き","つき","ひげ"]
//            question2.correctAnswer = "ひと"
//
//            let quiz0 = Quiz(context: context)
//            quiz0.isSuccessful = false
//            quiz0.quizIndex = 0
//            quiz0.addToQuestions(question0)
//            quiz0.addToQuestions(question1)
//            quiz0.addToQuestions(question2)
//
//            if quiz0.quizIndex != quiz.quizIndex {
//                saveQuiz()
//                print("saved new quiz data")
//            }
//            print("no data saved")
//        }
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    func saveQuiz() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func loadQuiz() {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        do {
            quizArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
