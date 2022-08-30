//
//  WeatherModel.swift
//  Clima
//
//  Created by Yuliya  on 8/30/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID{
        case 200...299: return "cloud.bolt.rain"
        case 300...399: return "cloud.drizzle"
        case 500...599: return "cloud.rain"
        case 600...699: return "cloud.snow.fill"
        case 701...771: return "smoke"
        case 781: return "tornado"
        case 800...899: return "sun.max"
        default: return "cloud"
        }
    }
}

