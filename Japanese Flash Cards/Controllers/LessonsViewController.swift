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
    let data = Data()
    var quizArray: [Quiz]?
    
    //MARK: - View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if seeds.isDatabaseEmpty() {
            seeds.seedData()
        }
        
        seeds.updateData()
        
        quizArray = seeds.getQuizArray()
        quizArray?.sort(by: { $0.quizIndex < $1.quizIndex})
        
        let buttonHeight = 100
        let buttonSpacing = 20
        let buttonWidth = 150
        let barRadius = 80
        let lineWidth = 15
        var successCount = 0
        var barProgressAmount: CGFloat = 0
        
        // Calculate quiz progress
        if let safeQuizArray = quizArray {
            for quiz in safeQuizArray {
                if quiz.isSuccessful {
                    successCount += 1
                }
            }
            barProgressAmount = CGFloat(successCount) / CGFloat(safeQuizArray.count)
        } else {
            print("quizArray has nil value!")
        }
        
        let scrollView = createScrollView(
                multipleItemsHeight: buttonHeight,
                multipleItemsSpacing: buttonSpacing,
                singleItemHeight: (barRadius + lineWidth) * 2,
                margin: 40,
                numberOfColumns: 2
        )
        _ = CircularProgressBar(
                barRadius: CGFloat(barRadius),
                lineWidth: CGFloat(lineWidth),
                xPos: view.center.x,
                yPos: 120,
                color: UIColor.systemTeal.cgColor,
                textSize: 60,
                animationDuration: 2 * barProgressAmount,
                progressAmount: barProgressAmount,
                selectedView: scrollView
        )
        generateButtons(
            buttonSpacing: buttonSpacing,
            buttonHeight: buttonHeight,
            buttonWidth: buttonWidth,
            topMargin: 250,
            quizArray: quizArray,
            scrollView: scrollView
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Segue Functions
    
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
    
    //MARK: - Generate UI
    
    func createScrollView(multipleItemsHeight: Int, multipleItemsSpacing: Int, singleItemHeight: Int, margin: Int, numberOfColumns: Int) -> UIScrollView {
        var scrollViewHeight: Float {
            return Float(((quizArray!.count * (multipleItemsHeight + multipleItemsSpacing)) / numberOfColumns) + (margin * 2) + singleItemHeight)
        }
        
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = #colorLiteral(red: 0.2134302557, green: 0.1230667606, blue: 0.2268092632, alpha: 1)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: CGFloat(scrollViewHeight))
        scrollView.contentInsetAdjustmentBehavior = .always
        
        return scrollView
    }
    
    func generateButtons(buttonSpacing: Int, buttonHeight: Int, buttonWidth: Int, topMargin: Int, quizArray: [Quiz]?, scrollView: UIScrollView) {
        if let safeQuizArray = quizArray {
            
            var buttonYPos = 0
            var buttonXPos = 0
            var buttonCounter = 0
            
            for quiz in safeQuizArray {
                
                if buttonCounter % 2 == 0 {
                    buttonXPos = Int(view.center.x) - buttonWidth - 10
                } else {
                    buttonXPos = Int(view.center.x) + 10
                }
                
                buttonYPos = ((buttonHeight + buttonSpacing) * (buttonCounter / 2)) + topMargin
                let button = TwoLinedButton(frame: CGRect(x: buttonXPos, y: buttonYPos, width: buttonWidth, height: buttonHeight))
                
                scrollView.addSubview(button)
                button.configure(with: TwoLinedButtonViewModel(primaryText: "Quiz \(quiz.quizIndex + 1)", secondaryText: quiz.quizName ?? "Go to Quiz"))
                
                button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
                
                if quiz.isSuccessful {
                    button.layer.borderColor = #colorLiteral(red: 0.6280703545, green: 0.7568953633, blue: 0.7201092839, alpha: 1)
                    button.setTitleColor(#colorLiteral(red: 0.6280703545, green: 0.7568953633, blue: 0.7201092839, alpha: 1), for: .normal)
                }
                
                buttonCounter += 1
            }
        } else {
            print("quizArray has nil value!")
        }
    }
}
