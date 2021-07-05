//
//  QuizBrain.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/05.
//

import Foundation

struct QuizBrain {
    var quiz = [
        Question(text: "月", answers: ["つき","き","にち","に"], correctAnswer: "つき"),
        Question(text: "日", answers: ["き","ひ","ち","は"], correctAnswer: "ひ"),
        Question(text: "人", answers: ["ひと","き","つき","ひげ"], correctAnswer: "ひと")
    ]
    
    var questionNumber = 0
    var correctScore = 0 // refresh this value at the end of the quiz
    var wrongCount = 0 // refresh this value for next question
    
    func checkAnswer(_ userAnswer: String) -> Bool {
        return userAnswer == quiz[questionNumber].correctAnswer
    }
    
    mutating func getNextQuestion() {
        wrongCount = 0
        if questionNumber >= quiz.count - 1 {
            questionNumber = 0
            print(getResult())
            correctScore = 0
        } else {
            questionNumber += 1
        }
    }
    
    mutating func shuffleAnswers() {
        quiz[questionNumber].answers.shuffle()
    }
    
    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    func getAnswerButtonText(index: Int) -> String {
        return quiz[questionNumber].answers[index]
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    func getResult() -> Int {
        return Int((Float(correctScore) / Float(quiz.count)) * 100)
    }
    
    func getWrongAnswerCount() -> Int {
        return wrongCount
    }
    
    mutating func increaseWrongAnswerCount() {
        wrongCount += 1
    }
    
    mutating func increaseScore() {
        correctScore += 1
    }
}
