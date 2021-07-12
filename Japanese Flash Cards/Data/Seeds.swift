//
//  Seeds.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/11.
//

import UIKit
import CoreData

class Seeds {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
    
    func seedData() -> Quiz {
        let quizFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Quiz")
        let quizDeleteRequest = NSBatchDeleteRequest(fetchRequest: quizFetchRequest)

        do {
            try persistentStoreCoordinator.execute(quizDeleteRequest, with: context)
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
        
        let quiz = Quiz(context: context)
        quiz.isSuccessful = false
        quiz.quizIndex = 0
        
        saveLesson()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        return quiz
    }
    
    func saveLesson() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}
