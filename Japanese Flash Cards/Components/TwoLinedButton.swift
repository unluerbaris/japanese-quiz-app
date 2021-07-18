//
//  TestButton.swift
//  Japanese Flash Cards
//
//  Created by Baris Unluer on 2021/07/18.
//

import UIKit

struct TwoLinedButtonViewModel {
    let primaryText: String
    let secondaryText: String
}

final class TwoLinedButton: UIButton {
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9230592251, green: 0.8625263572, blue: 0.7306218743, alpha: 1)
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.9230592251, green: 0.8625263572, blue: 0.7306218743, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        clipsToBounds = true
        layer.cornerRadius = 20.0
        layer.borderWidth = 1.0
        alpha = 1.0
        layer.borderColor = #colorLiteral(red: 0.9230592251, green: 0.8625263572, blue: 0.7306218743, alpha: 1)
        backgroundColor = #colorLiteral(red: 0.09018556029, green: 0.09020196646, blue: 0.09017995745, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel: TwoLinedButtonViewModel) {
        primaryLabel.text = viewModel.primaryText
        secondaryLabel.text = viewModel.secondaryText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        primaryLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height / 2)
        secondaryLabel.frame = CGRect(x: 0, y: frame.size.height / 2, width: frame.size.width, height: frame.size.height / 2)
    }
    
    func getPrimaryText() -> String {
        return primaryLabel.text ?? "No Text"
    }
    
    func getSecondaryText() -> String {
        return secondaryLabel.text ?? "No Text"
    }
}
