//
//  ViewController.swift
//  Weather
//
//  Created by serenite on 24.01.2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var getWeatherButton: UIButton!
    
    var longitude: Double = 0.0
    var latitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
        var currentLocation: CLLocation!
        
        switch locManager.authorizationStatus {
        case .restricted, .denied:
            print("switch is failed.")
        default:
            currentLocation = locManager.location
        }
        
        longitude = currentLocation.coordinate.longitude
        latitude = currentLocation.coordinate.latitude
        
    }
    
    @objc func didTapGetWeatherButton() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(self.latitude)&longitude=\(self.longitude)&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherLabel.text = "\(weather.current.temperature2M)°"
                    }
                }
            else {
                    self.weatherLabel.text = 
                        "Temperature is undefined."
                }
            }
        
        task.resume()
    }
}

