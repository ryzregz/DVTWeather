//
//  EndPoints.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

enum Endpoint {
    case weather
    case forecast
}

extension Endpoint: API {
    var endpoint: String {
        switch self {
        case .weather: return RequestPaths(config: AppDelegate.AppConfig!).CURRENT_WEATHER_PATH
        case .forecast: return RequestPaths(config: AppDelegate.AppConfig!).FORECAST_PATH
        }
    }
    
    var host : String{
        return RequestPaths(config: AppDelegate.AppConfig!).HOST
    }
    
    var scheme : String{
        return RequestPaths(config: AppDelegate.AppConfig!).SCHEME
    }
}
