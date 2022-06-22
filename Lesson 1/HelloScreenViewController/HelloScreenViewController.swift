//
//  helloScreenViewController.swift
//  fefuactivity
//
//  Created by Котик on 04.05.2022.
//

import UIKit


class HelloScreenViewController: UIViewController {
    
    private let headerView: UIImageView = {
        let header = UIImageView()
        header.clipsToBounds = true
        header.image = UIImage(named: "gradient")
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private let logoView: UIImageView = {
        let header = UIImageView()
        header.clipsToBounds = true
        header.image = UIImage(named: "logoColor")
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private let createAccountButton: MyButton = {
        let button = MyButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()
    
    private let loginButton: MyButton = {
        let button = MyButton()
        button.setTitle("Уже есть аккаунт?", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(Pallete.blueColor, for: .normal)
        return button
    }()
    
    private let dvfuLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.07
        paragraphStyle.alignment = .center
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.attributedText = NSMutableAttributedString(string: "Пожалуй лучший\nфитнес трекер в ДВФУ", attributes: [
            NSAttributedString.Key.kern: 0.35,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        return label
    }()
    
    private let studentLabel: UILabel = {
        let label = UILabel()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        paragraphStyle.alignment = .center
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.attributedText = NSMutableAttributedString(string: "Созданный студентами 2 - ого курса", attributes: [
            NSAttributedString.Key.kern: -0.24,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)
        view.backgroundColor = .systemBackground
        
        loginButton.addTarget(self,
                              action: #selector(handleShowLogin),
                              for: .touchUpInside)
        createAccountButton.addTarget(self,
                                      action: #selector(handleShowRegistration),
                                      for: .touchUpInside)
        
        addSubviews()
        layoutConstraints()
    }
    
    func addSubviews() {
        view.addSubview(logoView)
        view.addSubview(createAccountButton)
        view.addSubview(loginButton)
        view.addSubview(headerView)
        view.addSubview(dvfuLabel)
        view.addSubview(studentLabel)
    }
    
    func layoutConstraints() {
        NSLayoutConstraint.activate([
            logoView.widthAnchor.constraint(equalToConstant: 109.5),
            logoView.heightAnchor.constraint(equalToConstant: 111.22),
            logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 266),
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 250),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            
            dvfuLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 434),
            dvfuLabel.widthAnchor.constraint(equalToConstant: 343),
            dvfuLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            studentLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 510.17),
            studentLabel.widthAnchor.constraint(equalToConstant: 343),
            studentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            createAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            createAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            createAccountButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -24),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            createAccountButton.widthAnchor.constraint(equalToConstant: 311),
            
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -66),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalToConstant: 311)
        ])
    }
    
    @objc func handleShowRegistration() {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
    
    @objc func handleShowLogin() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
