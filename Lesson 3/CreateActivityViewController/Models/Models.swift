//
//  Models.swift
//  fefuactivity
//
//  Created by Котик on 06.06.2022.
//

import Foundation
import UIKit


enum ActivityTypes: String {
    case bike
    case run
    case walking
}

struct ActivityStartItem {
    let title: String
    let image: UIImage?
    let type: ActivityTypes
}

