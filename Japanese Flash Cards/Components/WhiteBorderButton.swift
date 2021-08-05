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
        backgroundColor = #colorLiteral(red: 0.2134302557, green: 0.1230667606, blue: 0.2268092632, alpha: 1)
        layer.cornerRadius = 20.0
        layer.borderWidth = 2.0
        layer.borderColor = #colorLiteral(red: 0.4452409148, green: 0.6250732541, blue: 0.6886933446, alpha: 1)
        tintColor = UIColor.white
    }
}
