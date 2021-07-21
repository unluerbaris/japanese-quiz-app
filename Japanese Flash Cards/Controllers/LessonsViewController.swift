//
//  LessonsViewController.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/09.
//

import UIKit

class LessonsViewController: UIViewController {
        
    var targetButton: TwoLinedButton?
    let seeds = Seeds()
    var quizArray: [Quiz]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // seeds.seedData()
        
        quizArray = seeds.getQuizArray()
        quizArray?.sort(by: { $0.quizIndex < $1.quizIndex})
        
        var scrollViewHeight: Float {
            return Float(quizArray!.count * 100)
        }
        
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = #colorLiteral(red: 0.09018556029, green: 0.09020196646, blue: 0.09017995745, alpha: 1)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: CGFloat(scrollViewHeight))
        scrollView.contentInsetAdjustmentBehavior = .always
        
        if let safeQuizArray = quizArray {
            
            var buttonYPos = 0
            var buttonCounter = 0
            let buttonSpacing = 20
            let buttonHeight = 80
            
            for quiz in safeQuizArray {
                
                buttonYPos = (buttonHeight + buttonSpacing) * buttonCounter
                let button = TwoLinedButton(frame: CGRect(x: 0, y: buttonYPos, width: 200, height: buttonHeight))
                
                scrollView.addSubview(button)
                button.center.x = view.center.x
                button.configure(with: TwoLinedButtonViewModel(primaryText: "Quiz \(quiz.quizIndex + 1)", secondaryText: quiz.quizName ?? "Go to Quiz"))
                
                button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
                
                if quiz.isSuccessful {
                    button.layer.borderColor = #colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1)
                    button.setTitleColor(#colorLiteral(red: 0.2099479735, green: 0.4098468721, blue: 0.3193167746, alpha: 1), for: .normal)
                }
                
                buttonCounter += 1
            }
        } else {
            print("quizArray has nil value!")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func action(sender: TwoLinedButton) {
        targetButton = sender
        self.performSegue(withIdentifier: "goToLesson", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLesson" {
            let destinationVC = segue.destination as! QuizViewController
            let buttonTextArray = targetButton?.getPrimaryText().split(separator: " ")
            destinationVC.quizIndex = Int64(buttonTextArray![1])! - Int64(1)
        }
    }
}
