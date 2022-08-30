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
    
    
    var delegate: APIManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task =  session.dataTask(with: url) { data, responce, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
              //      DispatchQueue.main.async {
                        
                        if let weather = parseJSON(safeData) {
                            delegate?.didUpdateWeather(self, weather: weather)
                        }
                //    }
                    
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}

protocol APIManagerDelegate {
    func didUpdateWeather(_ apiManager: APIManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
