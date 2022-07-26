//
//  SavedLocationRepository.swift
//  lloydweatherapp
//
//  Created by Lloyd T Mashumba on 26/7/2022.
//

import Foundation
import CoreData

protocol SavedLocationRepository{
    
    func getAllSavedLocations(handler :([SavedLocation])->Void)
    func saveLocationFor(lat: Double,lon : Double,weather : CurrentWeather,handler: (Bool) -> Void)
}

class SavedLocationService : SavedLocationRepository{
    
    static let shared = SavedLocationService()
    
    private init(){}
    
    private var context : NSManagedObjectContext {
        return appdelegate.persistentContainer.viewContext
    }
    
    func getAllSavedLocations(handler : ([SavedLocation])->Void) {
        do{
            handler(try context.fetch(SavedLocation.fetchRequest()))
        }catch{
            handler([SavedLocation]())
        }
    }
    
    
    func saveLocationFor(lat: Double, lon: Double, weather: CurrentWeather, handler: (Bool) -> Void) {
        do {
            let location = SavedLocation(context: context)
            location.city = weather.city
            location.lat = lat
            location.lon = lon
            location.id = UUID()
            location.savedOn = Date()
            try context.save()
            handler(true)
        } catch{
            handler(false)
        }
    }
    
}
