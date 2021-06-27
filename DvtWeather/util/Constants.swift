//
//  Constants.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/18/21.
//

import Foundation
struct Constants{
    static let DEFAULT_USER_STORE_KEY = "userInformation"
    public static let KEY_SERVICE_ERROR = "service-error"
    public static let KEY_APPID = "appid"
    
    //API Errors
    public static let KEY_API_ERROR = "APIError - Request Failed ->"
    public static let KEY_INVALID_DATA = "Invalid Data"
    public static let KEY_RESPONSE_UNSUCCESSFUL = "APIError - Response Unsuccessful status code ->"
    public static let KEY_JSON_DECODING_ERROR = "APIError - JSON decoding Failure"
    public static let KEY_JSON_CONVERSION_ERROR = "APIError - JSON Conversion Failure ->"
    public static let KEY_DECODING_TASK_ERROR = "APIError - decodingtask failure with error ->"
    public static let KEY_PARAMETER_ENCODING_ERROR = "APIError - post parameters failure ->"
    public static let KEY_REQUEST_FAILED = "Request Failed with no response description"
   
    
    //Other Errors
    public static let KEY_CONFIG_READ_ERROR = "Config Read Error ::"
    public static let KEY_LOCATION_ERROR = "Location Error ->"
    public static let KEY_GOOGLE_PLACE_ERROR = "Google  Places Location Error ->"
    public static let KEY_APP_DELEGATE_ERROR = "SceneDelegate is not UIApplication.shared.delegate"
    public static let KEY_ROOT_CONTROLLER_ERROR = "There is no root controller"
    public static let KEY_COREDATA_PERSISTENT_STORE_ERROR = "Failed to Load Persistence Store>>>"
    public static let KEY_COREDATA_SAVE_ERROR = "Core Data Save Entity Error>>"
    public static let KEY_COREDATA_FETCH_ERROR = "Core Data Fetch Entity Error>>"
    
    
    
    //Resources
    public static let KEY_CONFIG_FILE = "config"
    public static let KEY_PLIST_FILE = "plist"
    
    //Date Formats
    public static let KEY_DEFAULT_DATEFORMATTER = "yyyy-MM-dd HH:mm:ss"
    public static let KEY_DAY_DATEFORMATTER = "EEEE, MMM d"
    
    // Temparature Formater
    public static let KEY_LOCALE = "en_GB"
    
    //Image Names
    public static let KEY_FOREST_SUNNY_IMAGE = "forest_sunny"
    public static let KEY_FOREST_RAINY_IMAGE = "forest_rainy"
    public static let KEY_FOREST_CLOUDY_IMAGE = "forest_cloudy"
    
    //Cell Identifiers
    public static let KEY_FORECASTCELL_IDENTIFIER = "ForeCastCell"
    public static let KEY_FAVOURITESCELL_IDENTIFIER = "FavouritesCell"
    
    // Default City
    public static let KEY_DEFAULT_CITY = "Nairobi"
    
    //Search Controller Text
    public static let KEY_LOCATION_SEARCH_TEXT = "Search City"
    
    //Core data and Core Data Entities
    public static let KEY_APP_COREDATA = "DVTWeatherCoreData"
    public static let KEY_WEATHER_ENTITY = "WeatherEntity"
    public static let KEY_FORECAST_ENTITY = "ForecastEntity"
    public static let KEY_FAVOURITES_ENTITY = "FavouritesEntity"
    public static let KEY_SUCCESSFUL_DATA_PERSISTENCE = "Successfull CoreData Persistent for "
  
   
    
   
}
    
