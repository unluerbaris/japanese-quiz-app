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
        
        for (index, quiz) in data.n5.enumerated() {
            let newQuiz = Quiz(context: context)
            newQuiz.isSuccessful = false
            newQuiz.quizIndex = Int64(index)
            newQuiz.quizName = quiz["name"] as? String
            
            let questions = quiz["questions"] as? [[String: Any]]
            
            for question in questions! {
                let newQuestion = Question(context: context)
                newQuestion.text = question["text"] as? String
                newQuestion.answers = question["answers"] as? [String]
                newQuestion.correctAnswer = question["correctAnswer"] as? String
                newQuestion.shouldReview = false
                
                newQuiz.addToQuestions(newQuestion)
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
    
//    func checkQuiz(quiz: Quiz, index: Int) {
//        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
//        request.predicate = NSPredicate(format: "quizIndex == %i", index)
//
//        do {
//            let dbQuiz: Quiz
//            dbQuiz = try context.fetch(request)[0]
//            print("DB QNAME == QNAME : \(dbQuiz == quiz)")
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//    }
    
//    func checkData() {
//        loadQuiz()
//
//        for (index, quiz) in data.n5.enumerated() {
//
//            checkQuiz(quiz: quiz["questions"] as! [Any], index: index)
//
//            let questions = quiz["questions"] as? [[String: Any]]
//
//            for question in questions! {
//                print("QUESTION TEXT: \(question["text"] ?? "NO NAME")")
//                print("ANSWERS: \(question["answers"] ?? [])")
//                print("CORRECT ANSWER: \(question["correctAnswer"] ?? "NO NAME")")
//            }
//        }
//    }
}
