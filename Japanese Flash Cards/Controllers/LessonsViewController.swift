//
//  LessonsViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/09.
//

import UIKit

class LessonsViewController: UIViewController {
        
    var targetButton: WhiteBorderButton?
    let seeds = Seeds()
    var quizArray: [Quiz]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        seeds.seedData()
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = #colorLiteral(red: 0.09018556029, green: 0.09020196646, blue: 0.09017995745, alpha: 1)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 800)
        
        quizArray = seeds.getQuizArray()
        if let safeQuizArray = quizArray {
            
            var buttonSpacing = 0
            
            for quiz in safeQuizArray {
                let button = WhiteBorderButton(frame: CGRect(x: 20, y: 20 + buttonSpacing, width: 200, height: 80))
                buttonSpacing += 200
                
                button.setTitle("\(quiz.quizIndex)", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                scrollView.addSubview(button)
                button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
                
                if quiz.isSuccessful {
                    button.layer.borderColor = #colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1)
                    button.setTitleColor(#colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1), for: .normal)
                }
            }
        } else {
            print("quizArray has nil value!")
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
    
    @objc private func action(sender: WhiteBorderButton) {
        targetButton = sender
        self.performSegue(withIdentifier: "goToLesson", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLesson" {
            let destinationVC = segue.destination as! QuizViewController
            destinationVC.quizIndex = Int64((targetButton?.currentTitle) ?? "123")
        }
    }
}
