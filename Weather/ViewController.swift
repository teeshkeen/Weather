//
//  ViewController.swift
//  Weather
//
//  Created by serenite on 24.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var getWeatherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
    }
    
    @objc func didTapGetWeatherButton() {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.weatherLabel.text = "\(weather.current.temperature2M)°"
                }
                } else {
                    print("Fail.")
                }
            }
        task.resume()
    }


}

