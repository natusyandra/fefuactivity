//
//  ButtonModel.swift
//  fefuactivity
//
//  Created by Котик on 04.05.2022.
//

import Foundation
import UIKit


class MyButton: UIButton {
    
    struct Constants {
        static let cornerRadius: CGFloat = 10.0
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("", for: .normal)
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Pallete.blueColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Font.buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
