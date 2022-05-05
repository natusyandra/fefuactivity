//
//  ViewController.swift
//  fefuactivity
//
//  Created by Andrew L on 04.10.2021.
//

import UIKit


class LoginViewController: UIViewController {

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
    
    private let proceedButton: MyButton = {
        let button = MyButton()
        button.setTitle("Продолжить", for: .normal)
        button.backgroundColor = Pallete.blueColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let logoComeOn: UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "Come on")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let logoReg: logoView = {
        let bottom = logoView()
        return bottom
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.title = "Войти"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        addSubviews()
        layoutViews()
    }
    
    func addSubviews() {
        view.addSubview(userLoginField)
        view.addSubview(passwordField)
        view.addSubview(proceedButton)
        view.addSubview(logoComeOn)
        view.addSubview(logoReg)
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            userLoginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userLoginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            userLoginField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            userLoginField.heightAnchor.constraint(equalToConstant: 50),
            userLoginField.widthAnchor.constraint(equalToConstant: 343),

            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordField.topAnchor.constraint(equalTo: userLoginField.bottomAnchor, constant: 16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.widthAnchor.constraint(equalToConstant: 343),
            
            proceedButton.heightAnchor.constraint(equalToConstant: 50),
            proceedButton.widthAnchor.constraint(equalToConstant: 311),
            proceedButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            proceedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            proceedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            logoComeOn.heightAnchor.constraint(equalToConstant: 302),
            logoComeOn.widthAnchor.constraint(equalToConstant: 375),
            logoComeOn.topAnchor.constraint(equalTo: proceedButton.bottomAnchor, constant: 25),
            logoComeOn.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            logoReg.widthAnchor.constraint(equalToConstant: 87.23),
            logoReg.heightAnchor.constraint(equalToConstant: 56),
            logoReg.topAnchor.constraint(equalTo: logoComeOn.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            logoReg.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}

