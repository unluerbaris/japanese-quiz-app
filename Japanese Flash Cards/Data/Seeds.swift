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
    
    //MARK: - Create Data

    func seedData() {
        clearDatabase()
        
        var questionIndex = 0
        
        for (quizIndex, quiz) in data.n5.enumerated() {
            let newQuiz = createQuiz(index: Int64(quizIndex), quizName: quiz["name"] as? String)
            let questions = quiz["questions"] as? [[String: Any]]
            
            for question in questions! {
                createQuestion(
                    index: Int64(questionIndex),
                    text: question["text"] as? String,
                    answers: question["answers"] as? [String],
                    correctAnswer: question["correctAnswer"] as? String,
                    quiz: newQuiz
                )
                questionIndex += 1
            }
        }
        saveData()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    func createQuiz(index: Int64, quizName: String?) -> Quiz {
        let newQuiz = Quiz(context: context)
        newQuiz.isSuccessful = false
        newQuiz.quizIndex = index
        newQuiz.quizName = quizName
        
        return newQuiz
    }
    
    func createQuestion(index: Int64, text: String?, answers: [String]?, correctAnswer: String?, quiz: Quiz) {
        let newQuestion = Question(context: context)
        newQuestion.questionIndex = index
        newQuestion.text = text
        newQuestion.answers = answers
        newQuestion.correctAnswer = correctAnswer
        newQuestion.shouldReview = false
        
        quiz.addToQuestions(newQuestion)
    }
    
    //MARK: - Read Data
    
    func loadData() {
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        do {
            quizArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func getQuestionFromDatabase(index: Int) -> Question? {
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
    
    func getQuestionCount() -> Int {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        do {
            var questionData: [Question]?
            questionData = try context.fetch(request)
            return questionData?.count ?? 0
        } catch {
            print("Error fetching data from context \(error)")
        }
        return 0
    }
    
    //MARK: - Update Data
    
    func updateData() {
        loadData()
        addNewQuizData()
        
        for (index, quiz) in data.n5.enumerated() {
            updateQuiz(quiz: quiz, index: index)
        }
        saveData()
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func addNewQuizData() {
        if data.n5.count != quizArray?.count {
            var questionIndex = getQuestionCount()
            
            for quizIndex in (quizArray!.count)...(data.n5.count - 1) {
                let newQuiz = createQuiz(index: Int64(quizIndex), quizName: data.n5[quizIndex]["name"] as? String)
                let questions = data.n5[quizIndex]["questions"] as? [[String: Any]]
                print("Index \(quizIndex) Quiz Created")
                
                for question in questions! {
                    createQuestion(
                        index: Int64(questionIndex),
                        text: question["text"] as? String,
                        answers: question["answers"] as? [String],
                        correctAnswer: question["correctAnswer"] as? String,
                        quiz: newQuiz
                    )
                    print("Index \(questionIndex) Question Created")
                    questionIndex += 1
                }
            }
            saveData()
        }
    }
    
    func updateQuiz(quiz: [String : Any], index: Int) {
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
                
                let dbQuestion = getQuestionFromDatabase(index: questionCounter)
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
    
    //MARK: - Destroy Data
    
    func clearDatabase() {
        let questionFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let questionDeleteRequest = NSBatchDeleteRequest(fetchRequest: questionFetchRequest)

        do {
            try persistentStoreCoordinator.execute(questionDeleteRequest, with: context)
            print("Questions are removed!")
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
        
        let quizFetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Quiz")
        let quizDeleteRequest = NSBatchDeleteRequest(fetchRequest: quizFetchRequest)
        
        do {
            try persistentStoreCoordinator.execute(quizDeleteRequest, with: context)
            print("Quizzes are removed!")
        } catch let error as NSError {
            print("Data removing error \(error)")
        }
    }
    
    //MARK: - Getter Functions
    
    func getQuizArray() -> [Quiz] {
        loadData()
        return quizArray!
    }
}
