//
//  ViewController.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/18/21.
//

import UIKit
import CoreLocation
import GooglePlaces
class HomeVC: UIViewController {
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var titleTemparatureLabel : UILabel!
    @IBOutlet weak var weatherLabel : UILabel!
    @IBOutlet weak var weatherCoverImage : UIImageView!
    @IBOutlet weak var currentTemparatureLabel : UILabel!
    @IBOutlet weak var maximumTemparatureLabel : UILabel!
    @IBOutlet weak var minimumTemparatureLabel : UILabel!
    @IBOutlet weak var cityLabel : UILabel!
    let api = NetworkViewModel()
    let locationService = LocationService()
    private var weatherViewModel = WeatherViewModel()
    private var dataSource : GenericTableViewDatasource<ForecastCell,Weather>!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //request location authorization from user 
        locationService.requestLocationAuthorization()
        //get current location
        getCurrentLocation(completion: { result, error in
            guard let location = result else {
                self.showErrorAlert(withTitle: Constants.KEY_LOCATION_ERROR, message: error!.localizedDescription, completion: {(result)in
                    Logger.Log(from: self, with: error!.localizedDescription)
                    //Get Default Location
                    self.getWeatherForecastData(city: Constants.KEY_DEFAULT_CITY)
                    self.cityLabel.text = Constants.KEY_DEFAULT_CITY
                })
                return
            }
            location.placemark { placemark, error in
                guard let placemark = placemark else {
                    return
                }
                let city = placemark.locality!
                self.getWeatherForecastData(city: city)
                self.cityLabel.text = city
            }
        })
        
        self.weatherViewModel.setWeatherData = {
            CustomLoader.sharedInstance.hide()
            self.updateUIWithWeatherData()
        }
        
        self.weatherViewModel.setForecastData = {
            CustomLoader.sharedInstance.hide()
            self.updateUIWithForeCastData()
        }
        
        self.weatherViewModel.onErrorHandling = { error in
            CustomLoader.sharedInstance.hide()
            self.showErrorAlert(withTitle: Constants.KEY_API_ERROR, message: error!.customDescription, completion: {(result) in})
            Logger.Log(from: self, with: Constants.KEY_API_ERROR)
        }
        setupSearchView()
    }
    
    func getWeatherForecastData(city : String){
        CustomLoader.sharedInstance.show()
        let service = WeatherService(q: city)
        self.weatherViewModel.getWeatherData(params: service)
        self.weatherViewModel.getForecastData(params: service)
        updateLocationEntity(city: city)
    }
    
    func setupSearchView(){
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.text = Constants.KEY_LOCATION_SEARCH_TEXT
        // Place the search bar in the navigation item's title view.
        self.navigationItem.titleView = searchController?.searchBar
        
        // Don't hide the navigation bar because the search bar is in it.
        searchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
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
            return vals.first
        }.sorted{$0.dt < $1.dt}
        self.updateForecastEntity(weather: items)
        self.dataSource = GenericTableViewDatasource(cellIdentifier: Constants.KEY_FORECASTCELL_IDENTIFIER, items: items, configureCell: { (cell, weather) in
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
    
    func updateLocationEntity(city : String){
        DispatchQueue.main.async {
            CoreDataManager.shared.persistFavouriteLocations(city: city)
        }
        
    }
    
    func updateWeatherEntity(weather : Weather){
        DispatchQueue.main.async {
            CoreDataManager.shared.persistWeatherData(weather: weather)
        }
        
    }
    
    func updateForecastEntity(weather : [Weather]){
        
    }
    
    
}

extension HomeVC: GMSAutocompleteResultsViewControllerDelegate{
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        getWeatherForecastData(city: place.formattedAddress!)
        searchController?.searchBar.text = place.formattedAddress
        self.cityLabel.text = place.formattedAddress
        self.dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        Logger.Log(from: self, with: Constants.KEY_GOOGLE_PLACE_ERROR)
    }
}


