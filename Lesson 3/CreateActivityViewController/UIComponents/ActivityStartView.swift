//
//  ActivityStartUI.swift
//  fefuactivity
//
//  Created by Котик on 06.06.2022.
//

import UIKit


class ActivityStartView: UIView {
    
    private let goLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Погнали? :("
        label.font = UIFont.systemFont(ofSize: 22, weight: . semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let startButton: MyButton = {
        let button = MyButton()
        button.setTitle("Старт", for: .normal)
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
        addSubview(startButton)
        addSubview(goLabel)
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            
            goLabel.widthAnchor.constraint(equalToConstant: 133),
            goLabel.heightAnchor.constraint(equalToConstant: 28),
            goLabel.topAnchor.constraint(equalTo: topAnchor, constant: 33),
            goLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 140),
            
            startButton.heightAnchor.constraint(equalToConstant: 50),
            startButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            startButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
}

extension ActivityStartView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

