//
//  AppConfig.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/18/21.
//

import Foundation
struct Config: Decodable {
    var environments : [AppEnvironment]
    var clientName: String
    var headers : AppHeaders
    var messages:AppMessages
    //
    enum CodingKeys : String, CodingKey {
        case environments
        case clientName = "client-name"
        case headers
        case messages
        
    }
}


struct AppMessages:Decodable{
    var serviceError:String
    var connectionError:String
    var reqSuccess:String
    
    enum CodingKeys:String,CodingKey{
        case serviceError = "service-error"
        case connectionError = "conn-error"
        case reqSuccess = "request-success"
    }
}

struct AppHeaders:Decodable{
    var appid:String
    
    enum CodingKeys:String,CodingKey{
        case appid = "appid"
    }
}

struct AppEnvironment:Decodable {
    var name:String
    var active:Bool
    var appTimeout:Double
    var scheme:String
    var rootURL:String
    var baseURL:String
    var weatherEndpoint:String
    var forecastEndpoint:String
    enum CodingKeys:String,CodingKey{
        case name
        case active
        case scheme = "scheme"
        case rootURL = "host"
        case baseURL = "base-path"
        case appTimeout = "app-timeout"
        case weatherEndpoint = "weather-endpoint"
        case forecastEndpoint = "forecast-endpoint"
    }
}

