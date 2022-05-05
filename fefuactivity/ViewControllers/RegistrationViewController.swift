//
//  RegistrationViewController.swift
//  fefuactivity
//
//  Created by Котик on 04.05.2022.
//

import Foundation
import UIKit


class RegistrationViewController: UIViewController, UICollectionViewDelegate {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userLoginField: UITextField = {
        let field = UITextField()
        field.placeholder = "Логин"
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
    
    private let userNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Имя или никнейм"
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
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Пароль"
        field.returnKeyType = .continue
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
    
    private let doublePasswordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Повторите пароль"
        field.returnKeyType = .continue
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
    
    private let gender: UILabel = {
        let label = UILabel()
        label.text = "Пол"
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderSelect: UILabel = {
        let label = UILabel()
        label.text = "Выберите"
        label.textColor = .secondaryLabel
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let proceedButton: MyButton = {
        let button = MyButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = Pallete.blueColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let confidentLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        paragraphStyle.alignment = .center
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.attributedText = NSMutableAttributedString(string: "Нажимая на кнопку, вы соглашаетесь с\nполитикой конфиденциальности и обработки\nперсональных данных, а также принимаете\n пользовательское соглашение", attributes: [
            NSAttributedString.Key.kern: -0.24,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        return label
    }()
    
    private let logoReg: logoView = {
        let bottom = logoView()
        return bottom
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Регистрация"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        addSubviews()
        layoutViews()
    }
    
    func addSubviews() {
        view.addSubview(userNameField)
        view.addSubview(userLoginField)
        view.addSubview(passwordField)
        view.addSubview(doublePasswordField)
        view.addSubview(gender)
        view.addSubview(genderSelect)
        view.addSubview(proceedButton)
        view.addSubview(confidentLabel)
        view.addSubview(logoReg)
        
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            userLoginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userLoginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userLoginField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            userLoginField.heightAnchor.constraint(equalToConstant: 50),
            userLoginField.widthAnchor.constraint(equalToConstant: 343),
            
            userNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userNameField.topAnchor.constraint(equalTo: userLoginField.bottomAnchor, constant: 16),
            userNameField.heightAnchor.constraint(equalToConstant: 50),
            userNameField.widthAnchor.constraint(equalToConstant: 343),
            
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordField.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.widthAnchor.constraint(equalToConstant: 343),
            
            doublePasswordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            doublePasswordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            doublePasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            doublePasswordField.heightAnchor.constraint(equalToConstant: 50),
            doublePasswordField.widthAnchor.constraint(equalToConstant: 343),
            
            gender.heightAnchor.constraint(equalToConstant: 22),
            gender.widthAnchor.constraint(equalToConstant: 32),
            gender.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            gender.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -312),
            gender.topAnchor.constraint(equalTo: doublePasswordField.bottomAnchor, constant: 35),
            
            genderSelect.heightAnchor.constraint(equalToConstant: 22),
            genderSelect.widthAnchor.constraint(equalToConstant: 80),
            genderSelect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 244),
            genderSelect.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -51),
            genderSelect.topAnchor.constraint(equalTo: doublePasswordField.bottomAnchor, constant: 35),
            
            proceedButton.heightAnchor.constraint(equalToConstant: 50),
            proceedButton.widthAnchor.constraint(equalToConstant: 311),
            proceedButton.topAnchor.constraint(equalTo: doublePasswordField.bottomAnchor, constant: 106),
            proceedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            proceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            confidentLabel.topAnchor.constraint(equalTo: proceedButton.bottomAnchor, constant: 24),
            confidentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confidentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confidentLabel.widthAnchor.constraint(equalToConstant: 343),
            confidentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            logoReg.widthAnchor.constraint(equalToConstant: 87.23),
            logoReg.heightAnchor.constraint(equalToConstant: 56),
            logoReg.topAnchor.constraint(equalTo: confidentLabel.safeAreaLayoutGuide.bottomAnchor, constant: 48),
            logoReg.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}
