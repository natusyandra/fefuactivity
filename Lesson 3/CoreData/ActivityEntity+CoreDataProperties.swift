//
//  ActivityEntity+CoreDataProperties.swift
//  fefuactivity
//
//  Created by Котик on 14.06.2022.
//
//

import Foundation
import CoreData


extension ActivityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityEntity> {
        return NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
    }

    @NSManaged public var distance: Double
    @NSManaged public var type: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var finishTime: Date?
    @NSManaged public var timerData: Int

}

extension ActivityEntity : Identifiable {

}
