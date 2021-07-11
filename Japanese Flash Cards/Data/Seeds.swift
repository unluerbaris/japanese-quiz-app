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
    var questionsArray = [Question]()
    var lesson: Lesson?
    
    func seedData() -> Lesson {
        let questionsFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let questionsDeleteRequest = NSBatchDeleteRequest(fetchRequest: questionsFetchRequest)

        do {
            try persistentStoreCoordinator.execute(questionsDeleteRequest, with: context)
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
        
        let lessonsFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Lesson")
        let lessonsDeleteRequest = NSBatchDeleteRequest(fetchRequest: lessonsFetchRequest)

        do {
            try persistentStoreCoordinator.execute(lessonsDeleteRequest, with: context)
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
        
        let question1 = Question(context: context)
        question1.text = "月"
        question1.answers = ["つき","き","にち","に"]
        question1.correctAnswer = "つき"
        let question2 = Question(context: context)
        question2.text = "日"
        question2.answers = ["き","ひ","ち","は"]
        question2.correctAnswer = "ひ"
        let question3 = Question(context: context)
        question3.text = "人"
        question3.answers = ["ひと","き","つき","ひげ"]
        question3.correctAnswer = "ひと"
        questionsArray.append(question1)
        questionsArray.append(question2)
        questionsArray.append(question3)
        lesson = Lesson(context: context)
        lesson?.isSuccessful = false
        lesson?.lessonIndex = 0
        lesson?.quiz = questionsArray
        
        saveLesson()
        loadLesson()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        return lesson!
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
}
