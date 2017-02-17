//
//  ForecastCD+CoreDataProperties.swift
//  
//
//  Created by Sierra 4 on 17/02/17.
//
//

import Foundation
import CoreData


extension ForecastCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForecastCD> {
        return NSFetchRequest<ForecastCD>(entityName: "ForecastCD");
    }

    @NSManaged public var category: String?

}
