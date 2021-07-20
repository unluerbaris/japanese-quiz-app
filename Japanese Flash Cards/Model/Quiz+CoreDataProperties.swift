//
//  Quiz+CoreDataProperties.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/20.
//
//

import Foundation
import CoreData


extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var isSuccessful: Bool
    @NSManaged public var quizIndex: Int64
    @NSManaged public var quizName: String?
    @NSManaged public var questions: NSSet?

}

// MARK: Generated accessors for questions
extension Quiz {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}

extension Quiz : Identifiable {

}
