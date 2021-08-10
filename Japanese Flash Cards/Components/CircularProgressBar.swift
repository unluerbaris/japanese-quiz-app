//
//  CircularProgressBar.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/08/05.
//

import UIKit

class CircularProgressBar {
    var displayLink: CADisplayLink?
    let percentageLayer: CATextLayer?
    var animationDuration: CGFloat?
    var startValue: Double?
    var endValue: Double?
    let animationStartDate: Date?
    
    init(barRadius: CGFloat, lineWidth: CGFloat, xPos: CGFloat, yPos: CGFloat, color: CGColor, textSize: CGFloat, totalAnimationDuration: CGFloat, quizArray: [Quiz]?, scrollView: UIScrollView) {
        var successCount : Int = 0
        var progressAmount : CGFloat = 0
        self.animationDuration = 0
        self.startValue = 0
        self.endValue = 0
        self.animationStartDate = Date()
        
        if let safeQuizArray = quizArray {
            for quiz in safeQuizArray {
                if quiz.isSuccessful {
                    successCount += 1
                }
            }
            progressAmount = CGFloat(successCount) / CGFloat(safeQuizArray.count)
            self.endValue = Double(progressAmount * 100)
            self.animationDuration = totalAnimationDuration * progressAmount
        } else {
            print("quizArray has nil value!")
        }
        
        let trackPath = UIBezierPath(
                arcCenter: CGPoint(x: xPos, y: yPos),
                radius: barRadius,
                startAngle: -CGFloat.pi / 2,
                endAngle: ((CGFloat.pi * 3) / 2),
                clockwise: true
        )
        let progressPath = UIBezierPath(
                arcCenter: CGPoint(x: xPos, y: yPos),
                radius: barRadius,
                startAngle: -CGFloat.pi / 2,
                endAngle: (-CGFloat.pi / 2) + (CGFloat.pi * 2 * progressAmount),
                clockwise: true
        )
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = trackPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.fillColor = UIColor.clear.cgColor
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = progressPath.cgPath
        fillLayer.strokeColor = color
        fillLayer.lineWidth = lineWidth
        fillLayer.fillColor = UIColor.clear.cgColor
        fillLayer.lineCap = CAShapeLayerLineCap.round
        
        fillLayer.strokeEnd = 0
        
        percentageLayer = CATextLayer()
        percentageLayer?.font = UIFont(name: "HelveticaNeue-Bold", size: textSize)
        percentageLayer?.frame = CGRect(x: xPos - barRadius, y: yPos - (barRadius / 3.5), width: barRadius * 2, height: barRadius)
        percentageLayer?.string = "\(Int(progressAmount * 100))%"
        percentageLayer?.alignmentMode = CATextLayerAlignmentMode.center
        percentageLayer?.foregroundColor = UIColor.white.cgColor
        
        scrollView.layer.addSublayer(trackLayer)
        scrollView.layer.addSublayer(fillLayer)
        scrollView.layer.addSublayer(percentageLayer!)
        
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink?.add(to: .main, forMode: .default)
        
        let fillAnimation = CABasicAnimation(keyPath: "strokeEnd")
        fillAnimation.toValue = 1
        fillAnimation.duration = CFTimeInterval(self.animationDuration!)
        fillAnimation.fillMode = CAMediaTimingFillMode.forwards
        fillAnimation.isRemovedOnCompletion = false
        fillLayer.add(fillAnimation, forKey: "fillAnim")
    }
    
    @objc func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate!)
        
        if elapsedTime > CFTimeInterval(animationDuration!) {
            percentageLayer?.string = "\(Int(endValue!))%"
            print(endValue!)
            displayLink?.remove(from: .main, forMode: .default)
        } else {
            let percentage = elapsedTime / CFTimeInterval(animationDuration!)
            let value = startValue! + (percentage * (endValue! - startValue!))
            percentageLayer?.string = "\(Int(value))%"
        }
    }
}
