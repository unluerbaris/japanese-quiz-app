//
//  LessonsViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/09.
//

import UIKit

class LessonsViewController: UIViewController {
        
    @IBOutlet weak var lessonsStackView: UIStackView!
    let seeds = Seeds()
    var quizArray: [Quiz]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        seeds.seedData()
        quizArray = seeds.getQuizArray()
        
        for quiz in quizArray! {
            let button = UIButton()
            button.setTitle("\(quiz.quizIndex)", for: .normal)
            button.backgroundColor = UIColor.red
            button.translatesAutoresizingMaskIntoConstraints = false
            lessonsStackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        }
        
//        if seeds.getQuizArray()[0].isSuccessful {
//            lessonOneButton.layer.borderColor = #colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1)
//            lessonOneButton.setTitleColor(#colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1), for: .normal)
//        }
    }
    
    @objc private func action(sender: UIButton) {
        self.performSegue(withIdentifier: "goToLesson", sender: self)
    }
}
