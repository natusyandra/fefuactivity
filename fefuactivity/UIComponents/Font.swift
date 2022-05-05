//
//  Font.swift
//  fefuactivity
//
//  Created by Котик on 04.05.2022.
//

import Foundation
import UIKit


class Font {
    static var buttonTitle = get(size: 17, weight: .semibold)
    
    private static func get(size: CGFloat, weight: UIFont.Weight) -> UIFont  {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
