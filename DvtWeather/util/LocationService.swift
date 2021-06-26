//
//  LocationService.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/21/21.
//

import Foundation
import CoreLocation

enum LocationResult<T> {
  case success(T)
  case failure(Error)
}
class LocationService : NSObject{
    private let manager: CLLocationManager
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }

    var newLocation: ((LocationResult<CLLocation>) -> Void)?
    var didChangeStatus: ((Bool) -> Void)?

    var status: CLAuthorizationStatus {
        return manager.authorizationStatus
    }

    func requestLocationAuthorization() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
            //manager.startUpdatingHeading()
            print("Location Service is Enabled")
        }else{
            print("Location Service is not enabled")
        }
    }

    func getLocation() {
        manager.requestLocation()
    }

    deinit {
        manager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocation?(.failure(error))
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            newLocation?(.success(location))
        }
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)
        }
    }
}
