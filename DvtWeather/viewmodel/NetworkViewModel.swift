//
//  File.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/19/21.
//

import Foundation

class NetworkViewModel : NSObject, APIClient{
    
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience override init() {
        self.init(configuration: .default)
        if AppDelegate.AppConfig == nil {
            do {
                //
                if let url = Bundle.main.url(forResource: Constants.KEY_CONFIG_FILE, withExtension: Constants.KEY_PLIST_FILE) {
                    //
                    let data = try Data(contentsOf: url)
                    //
                 let config = try PropertyListDecoder().decode(Config.self, from: data)

                    //
                    AppDelegate.AppConfig = config
                }
            }catch{
                Logger.Log(from:NetworkViewModel.self,with:"\(Constants.KEY_CONFIG_READ_ERROR) \(error)")
            }
        }
    }
    
    //Get Current Weather API Call
    func getCurrentWeather(params : WeatherService, completion: @escaping (Result<Weather?, APIError>) -> Void){
        
        guard let request = Endpoint.weather.generateRequest(parameters: params, method: RequestTypes.get.rawValue) else { return}
        
        fetch(with: request, decode: { json -> Weather? in
            guard let results = json as? Weather else {return nil}
            
            return results
            
        }, completion: completion)
    }
    
    //Get Forecast API Call
    func getWeatherForecast(params : WeatherService, completion: @escaping (Result<Forecast?, APIError>) -> Void){
        guard let request = Endpoint.forecast.generateRequest(parameters: params, method: RequestTypes.get.rawValue) else { return}
        
        fetch(with: request, decode: { json -> Forecast? in
            guard let results = json as? Forecast else {return nil}
            
            return results
            
        }, completion: completion)
    }
    
}
