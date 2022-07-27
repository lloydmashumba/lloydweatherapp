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
    func deleteLocation(location : SavedLocation,handler: (Bool) -> Void)
}

class SavedLocationService : SavedLocationRepository{
    
    static let shared = SavedLocationService()
    
    private init(){}
    
    private var context : NSManagedObjectContext {
        return appdelegate.persistentContainer.viewContext
    }
    //get saved location data
    func getAllSavedLocations(handler : ([SavedLocation])->Void) {
        do{
            handler(try context.fetch(SavedLocation.fetchRequest()))
        }catch{
            handler([SavedLocation]())
        }
    }
    
    //save location update if exists
    func saveLocationFor(lat: Double, lon: Double, weather: CurrentWeather, handler: (Bool) -> Void) {
        do {
            let request = SavedLocation.fetchRequest()
            request.predicate = NSPredicate(format: "city = %@",weather.city)
            let locatons = try context.fetch(request)
            print(locatons.count)
            var location : SavedLocation?  = nil
            if(locatons.count > 0){location = locatons[0]}
            else {location = SavedLocation(context: context)}
            
            location!.city = weather.city
            location!.lat = lat
            location!.lon = lon
            location!.id = UUID()
            location!.savedOn = Date()
            try context.save()
            handler(true)
        } catch{
            handler(false)
        }
    }
    //delete location data
    func deleteLocation(location: SavedLocation, handler: (Bool) -> Void) {
        do{
            context.delete(location)
            try context.save()
            handler(true)
        }catch{
            handler(false)
        }
    }
    
}
