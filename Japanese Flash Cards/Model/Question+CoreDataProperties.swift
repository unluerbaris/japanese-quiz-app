//
//  Question+CoreDataProperties.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/18.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answers: [String]?
    @NSManaged public var correctAnswer: String?
    @NSManaged public var text: String?
    @NSManaged public var quiz: NSSet?

}

// MARK: Generated accessors for quiz
extension Question {

    @objc(addQuizObject:)
    @NSManaged public func addToQuiz(_ value: Quiz)

    @objc(removeQuizObject:)
    @NSManaged public func removeFromQuiz(_ value: Quiz)

    @objc(addQuiz:)
    @NSManaged public func addToQuiz(_ values: NSSet)

    @objc(removeQuiz:)
    @NSManaged public func removeFromQuiz(_ values: NSSet)

}

extension Question : Identifiable {

}
