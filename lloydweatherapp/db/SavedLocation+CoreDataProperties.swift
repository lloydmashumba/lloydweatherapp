//
//  SavedLocation+CoreDataProperties.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 24/7/2022.
//
//

import Foundation
import CoreData


extension SavedLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedLocation> {
        return NSFetchRequest<SavedLocation>(entityName: "SavedLocation")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var city: String?
    @NSManaged public var savedOn: Date?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double

}

extension SavedLocation : Identifiable {

}
