//
//  logoView.swift
//  fefuactivity
//
//  Created by Котик on 05.05.2022.
//

import UIKit


class logoView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        image = UIImage(named: "logoReg")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
