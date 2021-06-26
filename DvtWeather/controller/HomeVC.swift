//
//  ViewController.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/18/21.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var titleTemparatureLabel : UILabel!
    @IBOutlet weak var weatherLabel : UILabel!
    @IBOutlet weak var weatherCoverImage : UIImageView!
    @IBOutlet weak var currentTemparatureLabel : UILabel!
    @IBOutlet weak var maximumTemparatureLabel : UILabel!
    @IBOutlet weak var minimumTemparatureLabel : UILabel!
    let api = NetworkViewModel()
    let locationService = LocationService()
    private var weatherViewModel = WeatherViewModel()
    private var dataSource : GenericTableViewDatasource<ForecastCell,Weather>!
    let cellIdentifier = Constants.KEY_FORECASTCELL_IDENTIFIER
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //request location authorization from user 
        locationService.requestLocationAuthorization()
        //get current location
        getCurrentLocation(completion: { result, error in
            guard let location = result else {
                self.showErrorAlert(withTitle: Constants.KEY_LOCATION_ERROR, message: error!.localizedDescription, completion: {(result)in
                    //Get Default Location
                    let service = WeatherService(q: Constants.KEY_DEFAULT_CITY)
                    
                    self.weatherViewModel.getWeatherData(params: service)
                    self.weatherViewModel.getForecastData(params: service)
                })
                return
            }
            location.placemark { placemark, error in
                guard let placemark = placemark else {
                    return
                }
                
                let service = WeatherService(q: placemark.locality!)
                
                
                self.weatherViewModel.getWeatherData(params: service)
                self.weatherViewModel.getForecastData(params: service)
            }
            
            
        })
        
        self.weatherViewModel.setWeatherData = {
            self.updateUIWithWeatherData()
        }
        
        self.weatherViewModel.setForecastData = {
            self.updateUIWithForeCastData()
        }
        
        self.weatherViewModel.onErrorHandling = { error in
            self.showErrorAlert(withTitle: Constants.KEY_API_ERROR, message: error!.customDescription, completion: {(result) in})
        }
        
    }
    
    func updateUIWithWeatherData(){
        weatherLabel.text = weatherViewModel.weatherData.weather[0].main.rawValue
        titleTemparatureLabel.text = weatherViewModel.weatherData.main.temp.convertToTemparature()
        currentTemparatureLabel.text = weatherViewModel.weatherData.main.temp.convertToTemparature()
        maximumTemparatureLabel.text = weatherViewModel.weatherData.main.temp_max.convertToTemparature()
        minimumTemparatureLabel.text = weatherViewModel.weatherData.main.temp_min.convertToTemparature()
        switch weatherViewModel.weatherData.weather[0].main {
        case .Rain :
            weatherCoverImage.image = UIImage(named: Constants.KEY_FOREST_RAINY_IMAGE)
        case .Clouds:
            weatherCoverImage.image = UIImage(named: Constants.KEY_FOREST_CLOUDY_IMAGE)
        default :
            weatherCoverImage.image = UIImage(named: Constants.KEY_FOREST_SUNNY_IMAGE)
        }
        
        updateWeatherEntity(weather: weatherViewModel.weatherData)
    }
    
    func updateUIWithForeCastData(){
        let groupingByDay = Dictionary(grouping: self.weatherViewModel.forecastData.list, by: { $0.dt_txt!.split(separator: " ")[0] })
        //Get One item per group
        let items =  groupingByDay.values.compactMap { (vals) in
            return vals.first //or change to "vals.last"
        }.sorted{$0.dt < $1.dt}
        self.dataSource = GenericTableViewDatasource(cellIdentifier: cellIdentifier, items: items, configureCell: { (cell, weather) in
            cell.configureCellWithItem(weather: weather)
        })
        
        DispatchQueue.main.async {
            self.forecastTableView.dataSource = self.dataSource
            self.forecastTableView.reloadData()
        }
    }
    
    func getCurrentLocation(completion: @escaping (CLLocation?, Error?) -> Void){
        locationService.getLocation()
        locationService.newLocation = {result in
            switch result {
            case .success(let location):
                completion(location, nil)
            case .failure(let error):
                completion(nil,error)
            }
        }
    }
    
    
    func updateWeatherEntity(weather : Weather){
        
    }
    
    
}


