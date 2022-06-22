//
//  EmptyState.swift
//  fefuactivity
//
//  Created by Котик on 19.05.2022.
//

import UIKit


class EmptyState: UIView {
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = .black
        titleLabel.text = "Время потренить"
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return titleLabel
    }()
    
    let messageLabel: UILabel = {
        let messageLabel = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        messageLabel.attributedText = NSMutableAttributedString(string: "Нажимай на кнопку ниже и начинаем трекать активность", attributes: [
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .black
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        addSubview(titleLabel)
        addSubview(messageLabel)
        
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            messageLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
            messageLabel.widthAnchor.constraint(equalToConstant: 297),
            messageLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
        ])
    }
}
