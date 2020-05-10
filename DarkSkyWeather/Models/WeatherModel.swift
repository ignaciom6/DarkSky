//
//  WeatherModel.swift
//  DarkSkyWeather
//
//  Created by Ignacio on 10/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    var latitude: Double
    var longitude: Double
    var timezone: String
    var currently: CurrentlyWeatherModel
}
