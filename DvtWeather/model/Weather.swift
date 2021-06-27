//
//  Weather.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

class Weather : NSObject, Codable{
    var weather : [CurrentWeather]
    var main : Main
    var dt : Int
    var dt_txt : String?
    var id : Int?
    var name : String?
    var city : City?
    var cityName : String?
    
    enum CodingKeys : String , CodingKey {
        case weather
        case main
        case dt
        case id
        case name
        case dt_txt
        case city
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        weather = try container.decode([CurrentWeather].self, forKey: .weather)
        main = try container.decode(Main.self, forKey: .main)
        dt = try container.decode(Int.self, forKey: .dt)
        dt_txt = try container.decodeIfPresent(String.self, forKey: .dt_txt)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        city = try container.decodeIfPresent(City.self, forKey: .city)
    }
    
}


class CurrentWeather : NSObject, Codable{
    var id : Int
    var main : WeatherType
    var desc : String
    var icon : String
    
    enum CodingKeys : String, CodingKey {
        case id
        case main
        case desc = "description"
        case icon
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(WeatherType.self, forKey: .main)
        desc = try container.decode(String.self, forKey: .desc)
        icon = try container.decode(String.self, forKey: .icon)
    }
}

class Main : NSObject, Codable{
    var temp : Double
    var feels_like : Double
    var temp_min : Double
    var temp_max : Double
    var pressure : Int
    var humidity : Int
    
    enum CodingKeys : String, CodingKey {
        case temp
        case feels_like
        case temp_min
        case temp_max
        case pressure
        case humidity
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try container.decode(Double.self, forKey: .temp)
        feels_like = try container.decode(Double.self, forKey: .feels_like)
        temp_min = try container.decode(Double.self, forKey: .temp_min)
        temp_max = try container.decode(Double.self, forKey: .temp_max)
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
    }
}

class City: NSObject,Codable {
    var id : Int
    var name : String
    var coord : Coordinates
    var country_code : String
    
    enum CodingKeys : String, CodingKey{
        case id
        case name
        case coord
        case country_code = "country"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        coord = try container.decode(Coordinates.self, forKey: .coord)
        country_code = try container.decode(String.self, forKey: .country_code)
        
    }
    
}

class Coordinates : NSObject,Codable{
    var lat : Double
    var lon : Double
    
    enum CordingKeys : String, CodingKey{
        case lat
        case lon
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decode(Double.self, forKey: .lat)
        lon = try container.decode(Double.self, forKey: .lon)
    }
    
}

enum WeatherType : String, Codable {
    case Clouds
    case Rain
    case Clear
    case Snow
    case Extreme
}
