//
//  Models.swift
//  fefuactivity
//
//  Created by Котик on 06.06.2022.
//

import Foundation


enum ActivityTypes {
    case bike
    case run
    case walking
}

struct ActivityStartItem {
    let title: String
    let image: String
    let type: ActivityTypes
}
