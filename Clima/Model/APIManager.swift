//
//  APIManager.swift
//  Clima
//
//  Created by Yuliya  on 8/29/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct APIManager {
    // add your personal key
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
             let task =  session.dataTask(with: url) { data, responce, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                    
                  //  let dataString = String(data: safeData, encoding: .utf8)
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            
        } catch {
            print(error)
        }
    }
   
    
}
