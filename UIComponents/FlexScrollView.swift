//
//  FlexScrollView.swift
//  fefuactivity
//
//  Created by on 06.05.2022.
//

import Foundation
import UIKit


/// Этот класс реализует возможность добавлять весь необходиммый контент UIViewController-a в контейнер, который реагирет на появление клавиатуры и добвляет возможность скролла.
///
/// class CustomUIViewController: FlexScrollViewController
///
class FlexScrollViewController: UIViewController {
    
    private(set) lazy var scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alwaysBounceVertical = true
        return $0
    }(UIScrollView())
    
    /// Сюда добавлять весь контент для отображения. Не забываем про top и bottom constraints
    private(set) lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    /// Для маленьких экранов этим параметром регулируем скролл до низу
    public var minYOffset: CGFloat = 30
    /// Используется для переключения вызова метода показа клавиатуры
    public var isKeyboardNotificationEnabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNotification()
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        let constraint = contentView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        constraint.priority = UILayoutPriority(250)
        constraint.isActive = true
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard isKeyboardNotificationEnabled else { return }
        guard let userInfo = notification.userInfo,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        let keyboardFrameInView = view.convert((value).cgRectValue, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)
        
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: intersection.height, right: 0)
        if #available(iOS 13.0, *) {
            minYOffset = UIScreen.main.scale == 3 ? 0 : minYOffset
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        guard isKeyboardNotificationEnabled else { return }
        additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
