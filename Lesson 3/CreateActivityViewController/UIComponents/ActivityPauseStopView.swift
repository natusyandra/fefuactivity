//
//  ActivityPauseStopView.swift
//  fefuactivity
//
//  Created by Котик on 07.06.2022.
//

import UIKit


class ActivityPauseStopView: UIView {
    
    public var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: . semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: . regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        //        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.font = UIFont.monospacedSystemFont(ofSize: 24, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let pauseButton: CircleButton = {
        let button = CircleButton()
        button.setImage(UIImage(systemName: "pause.fill"),
                        for: .normal)
        return button
    }()
    
    public let finishButton: CircleButton = {
        let button = CircleButton()
        button.setImage(UIImage(named: "racingFlag"),
                        for: .normal)
        button.backgroundColor = Pallete.blueDark
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 25
        backgroundColor = .white
        
        setupViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(typeLabel)
        addSubview(distanceLabel)
        addSubview(timeLabel)
        addSubview(pauseButton)
        addSubview(finishButton)
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            
            typeLabel.widthAnchor.constraint(equalToConstant: 117),
            typeLabel.heightAnchor.constraint(equalToConstant: 28),
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            typeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            
            distanceLabel.widthAnchor.constraint(equalToConstant: 100),
            distanceLabel.heightAnchor.constraint(equalToConstant: 35),
            distanceLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 15),
            distanceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            
            timeLabel.widthAnchor.constraint(equalToConstant: 130),
            timeLabel.heightAnchor.constraint(equalToConstant: 35),
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 67),
            timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            
            pauseButton.widthAnchor.constraint(equalToConstant: 56),
            pauseButton.heightAnchor.constraint(equalToConstant: 56),
            pauseButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 142),
            pauseButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            
            finishButton.widthAnchor.constraint(equalToConstant: 56),
            finishButton.heightAnchor.constraint(equalToConstant: 56),
            finishButton.leftAnchor.constraint(equalTo: pauseButton.rightAnchor, constant: 16),
            finishButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        ])
    }
}
