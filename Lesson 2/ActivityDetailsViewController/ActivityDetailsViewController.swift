//
//  ActivityDetailsViewController.swift
//  fefuactivity
//
//  Created by Котик on 20.05.2022.
//

import UIKit


class ActivityDeteilsViewConttroller: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "14.32 км"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeAgoLabelLeft: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "14 часов назад"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1 ч 42 мин"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startFinishLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "Старт 14:49 · Финиш 16:31"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let meansLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Велосипед"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let meansSymbol: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "bikeIcon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let timeAgoLabelRight: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "14 часов назад"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentField: UITextField = {
        let field = UITextField()
        field.placeholder = "Комментарий"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(addTapped))
        
        addSubviews()
        layoutViews()
    }
    
    func addSubviews() {
        view.addSubview(distanceLabel)
        view.addSubview(timeAgoLabelLeft)
        view.addSubview(timeLabel)
        view.addSubview(meansLabel)
        view.addSubview(meansSymbol)
        view.addSubview(timeAgoLabelRight)
        view.addSubview(commentField)
        view.addSubview(startFinishLabel)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            distanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            distanceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            distanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            timeAgoLabelLeft.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            timeAgoLabelLeft.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 1),
            
            timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            timeLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 35),
            
            startFinishLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 1),
            startFinishLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            startFinishLabel.heightAnchor.constraint(equalToConstant: 18),
            
            meansSymbol.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            meansSymbol.topAnchor.constraint(equalTo: startFinishLabel.bottomAnchor, constant: 24),
            
            meansLabel.leftAnchor.constraint(equalTo: meansSymbol.rightAnchor, constant: 5.5),
            meansLabel.topAnchor.constraint(equalTo: startFinishLabel.bottomAnchor, constant: 24),
            
            timeAgoLabelRight.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            timeAgoLabelRight.topAnchor.constraint(equalTo: startFinishLabel.bottomAnchor, constant: 24),
            
            commentField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            commentField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            commentField.topAnchor.constraint(equalTo: meansLabel.bottomAnchor, constant: 31),
            commentField.heightAnchor.constraint(equalToConstant: 44),
            commentField.widthAnchor.constraint(equalToConstant: 311)
        ])
    }
    
    @objc func addTapped() {
        print("Share button clicked")
    }
}
