//
//  Question+CoreDataProperties.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/11.
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

}

extension Question : Identifiable {

}
