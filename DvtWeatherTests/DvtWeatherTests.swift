//
//  DvtWeatherTests.swift
//  DvtWeatherTests
//
//  Created by Morris Murega on 6/18/21.
//

import XCTest
import CoreLocation
import CoreData
@testable import DvtWeather

class DvtWeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIfgetCurrentLocationReturnsExpectedLocation() {

      let locationService = LocationService()
      let expectedLocation = CLLocation(latitude: 51.50998, longitude: -0.1337)
      let completionExpectation = expectation(description: "completion expectation")
        locationService.requestLocationAuthorization()
        locationService.newLocation = {
            result in
            completionExpectation.fulfill()
            switch result{
            case .success(let location):
                print(location.coordinate.latitude)
                XCTAssertEqual(location.coordinate.latitude,expectedLocation.coordinate.latitude)
                XCTAssertEqual(location.coordinate.longitude,expectedLocation.coordinate.longitude)
            case .failure(let error):
                  XCTAssertThrowsError(error)
            }
        }

         wait(for: [completionExpectation], timeout: 1)
      }
    
    
    
    func testCoreFetchWeatherRecordsData(){
        let manager = CoreDataManager()
        let expectedCount = 1
        XCTAssertEqual(manager.fetchPersistedWeatherData()?.count,expectedCount)
    }
    

}
