//
//  WeatherParams.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

class WeatherService : NSObject, Codable{
    var q : String?
    var lat : Double?
    var lon : Double?
    
    enum CodingKeys : String, CodingKey{
        case q
        case lat
        case lon
    }
    
    init(q: String) {
        self.q = q
    }
    
    init(lat : Double, lon : Double){
        self.lat = lat
        self.lon = lon
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        q = try container.decodeIfPresent(String.self, forKey: .q)
        lat = try container.decodeIfPresent(Double.self, forKey: .lat)
        lon = try container.decodeIfPresent(Double.self, forKey: .lon)
    }
}
