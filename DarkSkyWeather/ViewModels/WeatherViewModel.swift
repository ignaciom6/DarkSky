//
//  WeatherViewModel.swift
//  DarkSkyWeather
//
//  Created by Ignacio on 11/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject {
    
    private static let kLocationNeededError = "Location services needed"
    private static let kError = "Error"
    
    private var locationMgr: CLLocationManager?
    var cityNameModel = Box("Loading...")
    var tempModel = Box("--º")
    var date = Box("-")
    var weatherDesc = Box("-")
    var windSpeed = Box("-")
    var rainProb = Box("-")
    var humidity = Box("-")
    var error = Box("")
    
    override init() {
        super.init()
        getLocation()
    }
    
    func getLocation() {
        locationMgr = CLLocationManager()
        locationMgr?.requestAlwaysAuthorization()
        locationMgr?.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationMgr?.delegate = self
            locationMgr?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationMgr?.startUpdatingLocation()
        }
    }
    
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        DarkSkyService.weatherForLocation(latitude: location.latitude, longitude: location.longitude) { [weak self] (weatherModelData, error) in
            guard let self = self else {return}
            guard let weatherModelData = weatherModelData
                else{
                    self.error.value = error?.localizedDescription ?? WeatherViewModel.kError
                    return
            }
            self.cityNameModel.value = FormatterUtilities.getCityName(cityName: weatherModelData.timezone) 
            self.tempModel.value = FormatterUtilities.getFormattedTemp(fullTemp: weatherModelData.currently.temperature)
            self.date.value = FormatterUtilities.getDateFrom(unix: weatherModelData.currently.time)
            self.weatherDesc.value = weatherModelData.currently.summary
            self.windSpeed.value = String(weatherModelData.currently.windSpeed)
            self.rainProb.value = String(weatherModelData.currently.precipProbability)
            self.humidity.value = String(weatherModelData.currently.humidity)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            self.error.value = WeatherViewModel.kLocationNeededError
        }
    }
}
