//
//  QuizData.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/12.
//

import Foundation

struct QuizData {
    var n5 = [
        [
            Question(text: "月", answers: ["つき","き","にち","に"], correctAnswer: "つき"),
            Question(text: "日", answers: ["き","ひ","ち","は"], correctAnswer: "ひ"),
            Question(text: "人", answers: ["ひと","き","つき","ひげ"], correctAnswer: "ひと")
        ],
        [
            Question(text: "月2", answers: ["つき","き","にち","に"], correctAnswer: "つき"),
            Question(text: "日2", answers: ["き","ひ","ち","は"], correctAnswer: "ひ"),
            Question(text: "人2", answers: ["ひと","き","つき","ひげ"], correctAnswer: "ひと")
        ],
        [
            Question(text: "月3", answers: ["つき","き","にち","に"], correctAnswer: "つき"),
            Question(text: "日3", answers: ["き","ひ","ち","は"], correctAnswer: "ひ"),
            Question(text: "人3", answers: ["ひと","き","つき","ひげ"], correctAnswer: "ひと")
        ]
    ]
}
