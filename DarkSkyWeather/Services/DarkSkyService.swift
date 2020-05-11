//
//  DarkSkyService.swift
//  DarkSkyWeather
//
//  Created by Ignacio on 10/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import Foundation


class DarkSkyService {
    typealias WeatherDataCompletion = (WeatherModel?, Error?) -> ()
    
    private static let host = "api.darksky.net"
    private static let apiKey = "2bb07c3bece89caf533ac9a5d23d8417"
    private static let path = "/forecast/" + apiKey + "/"
    
    static func weatherForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        let locationPath = String(latitude)+","+String(longitude)
        let fullPath = path + locationPath
        
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = fullPath
        urlBuilder.queryItems = [URLQueryItem(name: "units", value: "si")]
        
        let url = urlBuilder.url!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherModel: WeatherModel = try decoder.decode(WeatherModel.self, from: data)
                    completion(weatherModel, error)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
