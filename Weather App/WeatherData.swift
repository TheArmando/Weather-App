//
//  WeatherData.swift
//  Weather App
//
//  Created by Armando Silveira on 5/30/17.
//  Copyright © 2017 Armando Silveira. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherData {

    var temperature: String
    var description: String
    var icon: String
    
    init(data: Any) {
        let json = JSON(data)
        let currentWeather = json["currently"]
        
        if let temperature = currentWeather["temperature"].float {
            self.temperature = String(format: "%.0f", temperature) + " °F"
        } else {
            self.temperature = "--"
        }
        
        self.description = currentWeather["summary"].string ?? "--"
        self.icon = currentWeather["icon"].string ?? "--"
    }
    
}
