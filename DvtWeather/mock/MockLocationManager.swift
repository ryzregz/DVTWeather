//
//  MockLocationManager.swift
//  DvtWeather
//
//  Created by Morris Murega on 6/27/21.
//

import Foundation
import CoreLocation

class MockLocationManager : LocationService{
    
    func getAuthorizationStatus() -> CLAuthorizationStatus {
            return CLLocationManager.authorizationStatus()
        }

        func isLocationServicesEnabled() -> Bool {
            return CLLocationManager.locationServicesEnabled()
        }
    
}
