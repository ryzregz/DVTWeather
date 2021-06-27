//
//  Location.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/27/21.
//

import Foundation

class Location : NSObject, Codable{
    var name : String
    var latitude : Double?
    var longitude : Double?
    var place_id : String?
    
    enum CodingKeys : String, CodingKey{
        case name
        case latitude
        case longitude
        case place_id
    }
    
    
    init(name : String) {
        self.name = name
    }
    
    init(name: String, latitude : Double, longitude : Double){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(name: String, latitude : Double, longitude : Double, place_id : String){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.place_id = place_id
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    
    
}
