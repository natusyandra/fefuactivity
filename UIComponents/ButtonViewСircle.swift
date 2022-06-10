//
//  ButtonViewСircle.swift
//  fefuactivity
//
//  Created by Котик on 07.06.2022.
//

import UIKit


class  CircleButton: UIButton {
    
    struct Constants {
        static let cornerRadius: CGFloat = 28.0
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFill
        frame = CGRect(x: 0, y: 0, width: 56, height: 56)
        layer.cornerRadius = Constants.cornerRadius
        backgroundColor = Pallete.blueColor
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
