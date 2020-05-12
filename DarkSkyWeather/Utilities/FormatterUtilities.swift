//
//  DateUtilities.swift
//  DarkSkyWeather
//
//  Created by Ignacio on 11/05/2020.
//  Copyright © 2020 Ignacio. All rights reserved.
//

import Foundation

class FormatterUtilities: NSObject {
    
    class func getDateFrom(unix: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unix))
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = NSLocale.current
        
        formatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        let strDate = formatter.string(from: date)
        
        return strDate
    }
    
    class func getCityName(cityName: String) -> String {
        let location = cityName.components(separatedBy: "/")
        let name = location.last ?? "N/A"
        
        return name.replacingOccurrences(of: "_", with: " ")
    }
    
    class func getFormattedTemp(fullTemp: Double) -> String {
        return String(format:"%.0f"+"º", fullTemp)
    }
}
