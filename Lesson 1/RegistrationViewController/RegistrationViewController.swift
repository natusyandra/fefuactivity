//
//  RegistrationViewController.swift
//  fefuactivity
//
//  Created by Котик on 04.05.2022.
//

import UIKit


class RegistrationViewController: FlexScrollViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    var selectedRow = 0
    
    var genderData = ["Женщина", "Мужчина", "Лобстер", "Рептилойд", "Другое"]
    
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
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Пол"
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pickerViewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выберите", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        label.attributedText = NSMutableAttributedString(
            string: "Нажимая на кнопку, вы соглашаетесь с\nполитикой конфиденциальности и обработки\nперсональных данных, а также принимаете\n пользовательское соглашение",
            attributes: [
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
        
        pickerViewButton.addTarget(self,
                                   action: #selector(popUpPicker),
                                   for: .touchUpInside)
        proceedButton.addTarget(self,
                                action: #selector(handleShowActivity),
                                for: .touchUpInside)
        
        addSubviews()
        layoutConstraints()
    }
    
    func addSubviews() {
        view.addSubview(userNameField)
        view.addSubview(userLoginField)
        view.addSubview(passwordField)
        view.addSubview(doublePasswordField)
        view.addSubview(pickerViewButton)
        view.addSubview(genderLabel)
        view.addSubview(proceedButton)
        view.addSubview(confidentLabel)
        view.addSubview(logoReg)
        scrollView.alwaysBounceVertical = false
        scrollView.keyboardDismissMode = .onDrag
    }
    
    @objc func handleShowActivity() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func popUpPicker() {
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 50, height: 50)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 350, height: 250))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])
        
        let alert = UIAlertController(title: "Как вы идентифицируете себя?", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = pickerViewButton
        alert.popoverPresentationController?.sourceRect = pickerViewButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Выбрать", style: .default, handler: { (UIAlertAction) in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            let selected = Array(self.genderData)[self.selectedRow]
            let gender = selected
            self.pickerViewButton.setTitle(gender, for: .normal)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func layoutConstraints() {
        
        NSLayoutConstraint.activate([
            userLoginField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            userLoginField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            userLoginField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
            userLoginField.heightAnchor.constraint(equalToConstant: 50),
            
            userNameField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            userNameField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            userNameField.topAnchor.constraint(equalTo: userLoginField.bottomAnchor, constant: 16),
            userNameField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            passwordField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            passwordField.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            doublePasswordField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            doublePasswordField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            doublePasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            doublePasswordField.heightAnchor.constraint(equalToConstant: 50),
            
            genderLabel.heightAnchor.constraint(equalToConstant: 22),
            genderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 31),
            genderLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -312),
            genderLabel.topAnchor.constraint(equalTo: doublePasswordField.bottomAnchor, constant: 35),
            
            pickerViewButton.heightAnchor.constraint(equalToConstant: 22),
            pickerViewButton.widthAnchor.constraint(equalToConstant: 100),
            pickerViewButton.leftAnchor.constraint(equalTo: genderLabel.rightAnchor, constant: 181),
            pickerViewButton.topAnchor.constraint(equalTo: doublePasswordField.bottomAnchor, constant: 35),
            
            proceedButton.heightAnchor.constraint(equalToConstant: 50),
            proceedButton.topAnchor.constraint(equalTo: doublePasswordField.bottomAnchor, constant: 106),
            proceedButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 32),
            proceedButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -32),
            
            confidentLabel.topAnchor.constraint(equalTo: proceedButton.bottomAnchor, constant: 24),
            confidentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            confidentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            logoReg.heightAnchor.constraint(equalToConstant: 56),
            logoReg.topAnchor.constraint(equalTo: confidentLabel.safeAreaLayoutGuide.bottomAnchor, constant: 48),
            logoReg.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            logoReg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -66)
        ])
    }
}

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        label.text = Array(genderData)[row]
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textColor = UIColor.black
        label.sizeToFit()
        return label
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 50
        
    }
}


