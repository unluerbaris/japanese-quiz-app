//
//  Lesson.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/09.
//

import Foundation

struct Lesson {
    let lessonIndex: Int
    var isSuccessful: Bool
    let quiz: Array<Question>
}
