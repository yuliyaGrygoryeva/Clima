//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchText: UITextField!
    
    var weatherManager = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.delegate = self
        
    }

    @IBAction func searchPressed(_ sender: Any) {
        searchText.endEditing(true)
        print(searchText.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        print(searchText.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchText.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchText.text = ""
    }
    
    
}

