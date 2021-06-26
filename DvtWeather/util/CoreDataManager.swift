//
//  CoreDataManager.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/25/21.
//

import Foundation
import CoreData

class CoreDataManager{
    static let shared = CoreDataManager()
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DVTWeatherCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveCurrentWeather(weather : Weather) -> WeatherEntity?{
        
        let context = persistentContainer.viewContext
        let weatherDetails = NSEntityDescription.insertNewObject(forEntityName: "WeatherEntity", into: context) as! WeatherEntity
         weatherDetails.dt = Int32(weather.dt)
         weatherDetails.temp = weather.main.temp
         weatherDetails.temp_max = weather.main.temp_max
         weatherDetails.temp_min = weather.main.temp_min
         weatherDetails.type = weather.weather[0].main.rawValue
        
        do {
            try context.save()
            return weatherDetails
        }catch(let createError){
            Logger.Log(from: self, with: "CoreData Error ->> \(createError)")
        }
        
        return nil
        
    
        
    }
    
    
    func getWeatherFromLocalStorage() -> WeatherEntity?{
        
        
        return nil
    }
}
