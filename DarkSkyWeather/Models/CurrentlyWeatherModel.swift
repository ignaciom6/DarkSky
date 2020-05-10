//
//  CurrentlyWeatherModel.swift
//  DarkSkyWeather
//
//  Created by Ignacio on 10/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import Foundation

struct CurrentlyWeatherModel: Codable {
    var time: Int
    var summary: String
    var precipProbability: Double
    var temperature: Double
}
