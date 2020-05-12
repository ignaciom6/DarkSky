//
//  DarkSkyServiceProtocol.swift
//  DarkSkyWeather
//
//  Created by Ignacio on 11/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import Foundation

protocol DarkSkyServiceProtocol {
    typealias WeatherDataCompletion = (WeatherModel?, Error?) -> ()

    static func weatherForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion)
}
