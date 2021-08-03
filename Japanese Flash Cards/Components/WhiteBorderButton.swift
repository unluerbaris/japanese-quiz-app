//
//  BorderedButton.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/07.
//

import UIKit

class WhiteBorderButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConfig()
    }
    
    func setConfig() {
        
        isEnabled = true
        alpha = 1.0
        backgroundColor = #colorLiteral(red: 0.1896352348, green: 0.2746583889, blue: 0.3858157962, alpha: 1)
        layer.cornerRadius = 20.0
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.7608113613, green: 0.768344147, blue: 0.768344147, alpha: 1)
        tintColor = #colorLiteral(red: 0.9591724277, green: 0.9593099952, blue: 0.9591423869, alpha: 1)
    }
}
