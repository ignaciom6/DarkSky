//
//  MockDarkSkyService.swift
//  DarkSkyWeatherTests
//
//  Created by Ignacio on 11/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import Foundation
@testable import DarkSkyWeather

class MockDarkSkyService {
    
}

extension MockDarkSkyService: DarkSkyServiceProtocol {
    typealias WeatherDataCompletion = (WeatherModel?, Error?) -> ()

    static func weatherForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        
        let mockWeather = WeatherModel(latitude: 59.3310373,
                                       longitude: 18.0706638,
                                       timezone: "Europe/Stockholm",
                                       currently: CurrentlyWeatherModel(time: 1537882620,
                                                                        summary: "Clear",
                                                                        precipProbability: 20.13,
                                                                        temperature: 28.46,
                                                                        humidity: 0.65,
                                                                        windSpeed: 11.5))
        
        completion(mockWeather, nil)
    }
    

}
