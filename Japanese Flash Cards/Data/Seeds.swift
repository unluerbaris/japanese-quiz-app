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
//    let persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
    
    func seedData() {
//        let quizFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Quiz")
//        let quizDeleteRequest = NSBatchDeleteRequest(fetchRequest: quizFetchRequest)
//
//        do {
//            try persistentStoreCoordinator.execute(quizDeleteRequest, with: context)
//        } catch let error as NSError {
//            print("Data removing error \(error)")
//        }
        
        loadQuiz()
        
        for quiz in quizArray! {
            
            let quiz0 = Quiz(context: context)
            quiz0.isSuccessful = false
            quiz0.quizIndex = 0
            
            if quiz0.quizIndex != quiz.quizIndex {
                saveQuiz()
                print("saved new quiz data")
            }
            print("no data saved")
        }
        
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
        return quizArray!
    }
}
