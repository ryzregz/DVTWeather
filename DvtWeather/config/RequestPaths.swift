//
//  RequestPaths.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

class RequestPaths{
    public var SCHEME = ""
    
    public var HOST = ""
    
    public var BASE_PATH = ""
    
    public var FORECAST_PATH = ""
    
    public var CURRENT_WEATHER_PATH = ""
    
    init(config:Config){
        guard let env = config.environments.first(where: { (en) -> Bool in
            return en.active
        }) else{
            Logger.Log(from:self as AnyObject,with:"Could not read config..")
            return
        }
        
        //
        SCHEME = env.scheme
        HOST = env.rootURL
        BASE_PATH = env.baseURL
        CURRENT_WEATHER_PATH = "\(BASE_PATH)\(env.weatherEndpoint)"
        FORECAST_PATH = "\(BASE_PATH)\(env.forecastEndpoint)"
    }
}
