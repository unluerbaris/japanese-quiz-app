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
        backgroundColor = #colorLiteral(red: 0.09018556029, green: 0.09020196646, blue: 0.09017995745, alpha: 1)
        layer.cornerRadius = 20.0
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.9230592251, green: 0.8625263572, blue: 0.7306218743, alpha: 1)
        tintColor = #colorLiteral(red: 0.9230945706, green: 0.862467885, blue: 0.7350425124, alpha: 1)
    }
}
