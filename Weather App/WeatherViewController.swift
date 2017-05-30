//
//  WeatherViewController.swift
//  Weather App
//
//  Created by Armando Silveira on 5/30/17.
//  Copyright © 2017 Armando Silveira. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherLocation: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UILabel!
    
    
    let emojiIcons = [
        "clear-day" : "☀️",
        "clear-night" : "🌙",
        "rain" : "☔️",
        "snow" : "❄️",
        "sleet" : "🌨",
        "wind" : "🌬",
        "fog" : "🌫",
        "cloudy" : "☁️",
        "partly-cloudy-day" : "🌤",
        "partly-cloudy-night" : "🌥"
    ]
    
    let locationManager = CLLocationManager()
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    
    /*override func viewWillAppear(_ animated: Bool) {
        DarkSkyService.weatherForCoordinates(latitude: "37", longitude: "122") { (response, error) in
            print("\(response)")
            print("\(error)")
        }
    }
    */
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            DarkSkyService.weatherForCoordinates(latitude: latitude , longitude: longitude) { weatherData, error in
                
                if let weatherData = weatherData {
                    self.updateLabels(with: weatherData, at: location)
                }
                    
                else if let error = error {
                    print(error)
                }
                
            }
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleError(message: "Unable to load your location.")
    }
    
    func handleError(message: String) {
        let alert = UIAlertController(title: "Error Loading Forecast", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func updateLabels(with data: WeatherData, at location: CLLocation) {
        self.temperature.text = data.temperature
        self.weatherDescription.text = data.description
        //self.weatherIcon.text = data.icon
        self.weatherIcon.text = emojiIcons[data.icon] ?? "❓"
    }
}
