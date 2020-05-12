//
//  DarkSkyWeatherTests.swift
//  DarkSkyWeatherTests
//
//  Created by Ignacio on 10/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import XCTest
@testable import DarkSkyWeather

class DarkSkyWeatherTests: XCTestCase {
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDataReceivedForLocation() {
        
        let cityNameExp = self.expectation(description: "Get city name")
        let timeExp = self.expectation(description: "Get time")
        let tempExp = self.expectation(description: "Get temp")
        let summaryExp = self.expectation(description: "Get weather summary")
        let windExp = self.expectation(description: "Get wind speed")
        let rainExp = self.expectation(description: "Get rain probability")
        let humidityExp = self.expectation(description: "Get humidity percentage")
        
        let viewModel = WeatherViewModel()
        
        viewModel.cityNameModel.bind {
            if $0.caseInsensitiveCompare("Stockholm") == .orderedSame {
                cityNameExp.fulfill()
            }
        }
        
        viewModel.date.bind {
            if $0.caseInsensitiveCompare("Tue, 25 Sep 2018 13:37") == .orderedSame {
                timeExp.fulfill()
            }
        }
        
        viewModel.tempModel.bind {
            if $0.caseInsensitiveCompare("28º") == .orderedSame {
                tempExp.fulfill()
            }
        }
        
        viewModel.weatherDesc.bind {
            if $0.caseInsensitiveCompare("Clear") == .orderedSame {
                summaryExp.fulfill()
            }
        }
        
        viewModel.windSpeed.bind {
            if $0.caseInsensitiveCompare("11.5") == .orderedSame {
                windExp.fulfill()
            }
        }
        
        viewModel.rainProb.bind {
            if $0.caseInsensitiveCompare("20.13") == .orderedSame {
                rainExp.fulfill()
            }
        }
        
        viewModel.humidity.bind {
            if $0.caseInsensitiveCompare("0.65") == .orderedSame {
                humidityExp.fulfill()
            }
        }
        
        DispatchQueue.main.async {
            MockDarkSkyService.weatherForLocation(latitude: 59.3310373, longitude: 18.0706638) { (weatherModelData, error) in
                do {
                    viewModel.setPropertiesValuesFromData(weatherData: weatherModelData!)
                }
            }
        }
        
        waitForExpectations(timeout: 8, handler: nil)
        
    }

}
