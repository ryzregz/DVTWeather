//
//  Forecast.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

class Forecast : NSObject, Codable{
    var list : [Weather]
    
    enum CodingKeys : String, CodingKey {
        case list
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([Weather].self, forKey: .list)
    }
}
