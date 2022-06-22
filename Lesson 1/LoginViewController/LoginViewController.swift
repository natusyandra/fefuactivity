//
//  ViewController.swift
//  fefuactivity
//
//  Created by Andrew L on 04.10.2021.
//

import UIKit


class LoginViewController: FlexScrollViewController {
    
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
        image.image = UIImage(named: "comeOn")
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
        layoutConstraints()
        proceedButton.addTarget(self,
                                action: #selector(handleShowActivity),
                                for: .touchUpInside)
    }
    
    func addSubviews() {
        contentView.addSubview(userLoginField)
        contentView.addSubview(passwordField)
        contentView.addSubview(proceedButton)
        contentView.addSubview(logoComeOn)
        contentView.addSubview(logoReg)
        scrollView.alwaysBounceVertical = false
        scrollView.keyboardDismissMode = .onDrag
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            userLoginField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            userLoginField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            userLoginField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userLoginField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            passwordField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            passwordField.topAnchor.constraint(equalTo: userLoginField.bottomAnchor, constant: 16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            proceedButton.heightAnchor.constraint(equalToConstant: 50),
            proceedButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            proceedButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            proceedButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            
            logoComeOn.heightAnchor.constraint(equalToConstant: 302),
            logoComeOn.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            logoComeOn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            logoComeOn.topAnchor.constraint(equalTo: proceedButton.bottomAnchor, constant: 25),
            
            logoReg.widthAnchor.constraint(equalToConstant: 87.23),
            logoReg.heightAnchor.constraint(equalToConstant: 56),
            logoReg.topAnchor.constraint(greaterThanOrEqualTo: logoComeOn.bottomAnchor, constant: 1),
            logoReg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            logoReg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -66)
        ])
    }
    
    @objc func handleShowActivity() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
