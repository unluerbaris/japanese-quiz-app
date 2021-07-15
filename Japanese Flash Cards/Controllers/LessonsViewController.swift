//
//  LessonsViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/09.
//

import UIKit

class LessonsViewController: UIViewController {
        
    @IBOutlet weak var lessonsStackView: UIStackView!
    var targetButton: WhiteBorderButton?
    let seeds = Seeds()
    var quizArray: [Quiz]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        seeds.seedData()
        quizArray = seeds.getQuizArray()
        
        if let safeQuizArray = quizArray {
            for quiz in safeQuizArray {
                let button = WhiteBorderButton()
                button.setTitle("\(quiz.quizIndex)", for: .normal)
                button.translatesAutoresizingMaskIntoConstraints = false
                lessonsStackView.addArrangedSubview(button)
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
