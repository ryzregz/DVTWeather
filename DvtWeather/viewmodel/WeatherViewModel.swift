//
//  WeatherViewModel.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/20/21.
//

import Foundation



class WeatherViewModel : NSObject{
    
    private var api : NetworkViewModel!
    private(set) var forecastData : Forecast! {
        didSet {
            self.setForecastData()
        }
    }
    
    private(set) var weatherData : Weather! {
        didSet {
            self.setWeatherData()
        }
    }
    
    
    var setForecastData : (() -> ()) = {}
    var setWeatherData : (() -> ()) = {}
    var onErrorHandling : ((APIError?) -> Void)?
    
    override init() {
        super.init()
        self.api =  NetworkViewModel()
    }
    
    
    func getWeatherData(params: WeatherService){
        api.getCurrentWeather(params: params, completion: { [self]result in
            switch result{
            case .success(let weatherResults) :
                guard let weather =  weatherResults else {return}
                self.weatherData = weather
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        })
    }
    
    func getForecastData(params: WeatherService){
        api.getWeatherForecast(params: params, completion: { [self]result in
            switch result{
            case .success(let forecastResults) :
                guard let forecast =  forecastResults else {return}
                self.forecastData = forecast
            case .failure(let error):
                self.onErrorHandling?(error)
            }
        })
    }
    
    
}
