//
//  Quiz+CoreDataProperties.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/12.
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

}

extension Quiz : Identifiable {

}
