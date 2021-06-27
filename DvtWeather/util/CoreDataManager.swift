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
        let container = NSPersistentContainer(name: Constants.KEY_APP_COREDATA)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(Constants.KEY_COREDATA_PERSISTENT_STORE_ERROR) \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func persistWeatherData(weather : Weather) {
        let context = persistentContainer.viewContext
        let weatherDetails = NSEntityDescription.insertNewObject(forEntityName: Constants.KEY_WEATHER_ENTITY, into: context) as! WeatherEntity
        weatherDetails.dt = Int32(weather.dt)
        weatherDetails.temp = weather.main.temp
        weatherDetails.temp_max = weather.main.temp_max
        weatherDetails.temp_min = weather.main.temp_min
        weatherDetails.type = weather.weather[0].main.rawValue
        weatherDetails.city = weather.name
        
        do {
            try context.save()
            Logger.Log(from: self, with: "\(Constants.KEY_SUCCESSFUL_DATA_PERSISTENCE) \(Constants.KEY_WEATHER_ENTITY)")
        }catch(let createError){
            Logger.Log(from: self, with: "\(Constants.KEY_COREDATA_SAVE_ERROR) \(createError)")
        }
    }
    
    
    func persistForecastData(forecastList : [Weather]){
        for forecast in forecastList{
            let context = persistentContainer.viewContext
            let forecastDetails = NSEntityDescription.insertNewObject(forEntityName: Constants.KEY_FORECAST_ENTITY, into: context) as! ForecastEntity
            forecastDetails.city = forecast.city!.name
            forecastDetails.country_code = forecast.city!.country_code
            forecastDetails.dt = Int32(forecast.dt)
            forecastDetails.dt_txt = forecast.dt_txt
            forecastDetails.latitude = forecast.city!.coord.lat
            forecastDetails.longitude = forecast.city!.coord.lon
            forecastDetails.temp = forecast.main.temp
            forecastDetails.temp_max = forecast.main.temp_max
            forecastDetails.temp_min = forecast.main.temp_min
            
            do {
                try context.save()
                Logger.Log(from: self, with: "\(Constants.KEY_SUCCESSFUL_DATA_PERSISTENCE) \(Constants.KEY_FORECAST_ENTITY)")
            }catch(let createError){
                Logger.Log(from: self, with: "\(Constants.KEY_COREDATA_SAVE_ERROR) \(createError)")
            }
            
        }
    }
    
    func persistFavouriteLocations(city : String){
        let context = persistentContainer.viewContext
        let locationDetails = NSEntityDescription.insertNewObject(forEntityName: Constants.KEY_FAVOURITES_ENTITY, into: context) as! FavouritesEntity
        locationDetails.name = city
        do {
            try context.save()
            Logger.Log(from: self, with: "\(Constants.KEY_SUCCESSFUL_DATA_PERSISTENCE) \(Constants.KEY_FAVOURITES_ENTITY)")
        }catch(let createError){
            Logger.Log(from: self, with: "\(Constants.KEY_COREDATA_SAVE_ERROR) \(createError)")
        }
        
    }
    
    
    func fetchPersistedWeatherData() -> [NSDictionary]?{
        let context = persistentContainer.viewContext
        let fetchWeatherDetails = NSFetchRequest<NSDictionary>(entityName: Constants.KEY_WEATHER_ENTITY)
        fetchWeatherDetails.resultType = .dictionaryResultType
        do {
            return try context.fetch(fetchWeatherDetails)
          } catch (let fetchError) {
            Logger.Log(from: self, with: "\(Constants.KEY_COREDATA_FETCH_ERROR) \(fetchError)")
          }
        return nil
    }
    
    func fetchPersistedFavouritesData() -> [NSDictionary]?{
        let context = persistentContainer.viewContext
        let fetchFavouritesDetails = NSFetchRequest<NSDictionary>(entityName: Constants.KEY_FAVOURITES_ENTITY)
        fetchFavouritesDetails.resultType = .dictionaryResultType
        do {
            return try context.fetch(fetchFavouritesDetails)
          } catch (let fetchError) {
            Logger.Log(from: self, with: "\(Constants.KEY_COREDATA_FETCH_ERROR) \(fetchError)")
          }
        return nil
    }
    
    
}
