//
//  WeatherViewController.swift
//  DarkSkyWeather
//
//  Created by Ignacio on 10/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    private let kError = "Error"
    private let kOK = "OK"
    private let viewModel = WeatherViewModel()
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var temp: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var weatherDesc: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var rainProb: UILabel!
    @IBOutlet var humidity: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.cityNameModel.bind { [weak self] cityName in
            self?.cityName.text = cityName
        }
        
        viewModel.tempModel.bind { [weak self] temp in
            self?.temp.text = temp
        }
        
        viewModel.date.bind { [weak self] date in
            self?.date.text = date
        }
        
        viewModel.weatherDesc.bind { [weak self] weatherDesc in
            self?.weatherDesc.text = weatherDesc
        }
        
        viewModel.windSpeed.bind { [weak self] wind in
            self?.windSpeed.text = wind
        }
        
        viewModel.rainProb.bind { [weak self] rain in
            self?.rainProb.text = rain
        }
        
        viewModel.humidity.bind { [weak self] humidity in
            self?.humidity.text = humidity
        }
        
        viewModel.error.bind { [weak self] error in
            if !error.isEmpty {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: self?.kError, message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: self?.kOK, style: .default, handler: { (UIAlertAction) in
                        self?.dismiss(animated: true, completion: nil)
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }

}
