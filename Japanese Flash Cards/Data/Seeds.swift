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
    let data = Data()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
    var questionCounter = 0
    
    func seedData() {
        let quizFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Quiz")
        let quizDeleteRequest = NSBatchDeleteRequest(fetchRequest: quizFetchRequest)
        
        do {
            try persistentStoreCoordinator.execute(quizDeleteRequest, with: context)
        } catch let error as NSError {
            print("Data removing error \(error)")
        }

        let questionFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let questionDeleteRequest = NSBatchDeleteRequest(fetchRequest: questionFetchRequest)

        do {
            try persistentStoreCoordinator.execute(questionDeleteRequest, with: context)
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
        
        var questionIndex = 0
        
        for (quizIndex, quiz) in data.n5.enumerated() {
            let newQuiz = Quiz(context: context)
            newQuiz.isSuccessful = false
            newQuiz.quizIndex = Int64(quizIndex)
            newQuiz.quizName = quiz["name"] as? String
            
            let questions = quiz["questions"] as? [[String: Any]]
            
            for question in questions! {
                let newQuestion = Question(context: context)
                newQuestion.questionIndex = Int64(questionIndex)
                newQuestion.text = question["text"] as? String
                newQuestion.answers = question["answers"] as? [String]
                newQuestion.correctAnswer = question["correctAnswer"] as? String
                newQuestion.shouldReview = false
                
                newQuiz.addToQuestions(newQuestion)
                questionIndex += 1
            }
        }
        saveQuiz()
        
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
    
    func getQuizArray() -> [Quiz] {
        loadQuiz()
        return quizArray!
    }
    
    func getQuizCount() -> Int {
        loadQuiz()
        return quizArray?.count ?? 0
    }
    
    func updateData() {
        loadQuiz()
        for (index, quiz) in data.n5.enumerated() {
            checkQuiz(quiz: quiz, index: index)
        }
        saveQuiz()
    }
    
    func checkQuiz(quiz: [String : Any], index: Int) {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        request.predicate = NSPredicate(format: "quizIndex == %i", index)

        do {
            let dbQuiz: Quiz
            dbQuiz = try context.fetch(request)[0]
            if dbQuiz.quizName != quiz["name"] as? String {
                print("Updated quiz name from \(String(describing: dbQuiz.quizName)) to \(String(describing: quiz["name"]))")
                dbQuiz.quizName = quiz["name"] as? String
            }
            
            let questions = quiz["questions"] as? [[String: Any]]
            for question in questions! {
                
                let dbQuestion = getDBQuestion(index: questionCounter)
                questionCounter += 1
                
                if dbQuestion?.text != question["text"] as? String {
                    print("Updated question text from \(String(describing: dbQuestion?.text)) to \(String(describing: question["text"]))")
                    dbQuestion?.text = question["text"] as? String
                }
                if dbQuestion?.answers != question["answers"] as? [String] {
                    print("Updated question answers from \(String(describing: dbQuestion?.answers)) to \(String(describing: question["answers"] as? [String]))")
                    dbQuestion?.answers = question["answers"] as? [String]
                }
                if dbQuestion?.correctAnswer != question["correctAnswer"] as? String {
                    print("Updated correct answer from \(String(describing: dbQuestion?.correctAnswer)) to \(String(describing: question["correctAnswer"]))")
                    dbQuestion?.correctAnswer = question["correctAnswer"] as? String
                }
            }
            
        } catch {
            print("Error fetching data from context \(error)")
        }
    }

    
    func getDBQuestion(index: Int) -> Question? {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        request.predicate = NSPredicate(format: "questionIndex == %i", index)
        
        do {
            let question = try context.fetch(request)[0]
            return question
        } catch  {
            print("Error fetching data from context \(error)")
        }
        return nil
    }
    
    func isDatabaseEmpty() -> Bool {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        do {
            var quizData: [Quiz]?
            quizData = try context.fetch(request)
            if quizData!.count <= 0 {
                return true
            }
            return false
        } catch {
            print("Error fetching data from context \(error)")
        }
        return false
    }
}
