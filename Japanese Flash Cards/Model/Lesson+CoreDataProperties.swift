//
//  Lesson+CoreDataProperties.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/11.
//
//

import Foundation
import CoreData


extension Lesson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lesson> {
        return NSFetchRequest<Lesson>(entityName: "Lesson")
    }

    @NSManaged public var isSuccessful: Bool
    @NSManaged public var lessonIndex: Int64
    @NSManaged public var quiz: [Question]?

}

extension Lesson : Identifiable {

}
