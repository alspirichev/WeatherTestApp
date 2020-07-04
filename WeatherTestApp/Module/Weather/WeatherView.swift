//
//  WeatherView.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var countryLabel: UILabel!
    
    @IBOutlet weak private var commentLabel: UILabel!
    @IBOutlet weak private var cityImageView: UIImageView!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak private var weatherDescriptionLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var fahrenheitSwitch: UISwitch!
    
    private var temperature: Double!
    
    // MARK: - IBActions

    @IBAction func convertToFahrenheit(_ sender: UISwitch) {
        guard let _ = temperature else {
            fahrenheitSwitch.isOn = false
            return
        }
        
        switch sender.isOn {
            case true:
                let fahrenheitTemperature = (temperature - 32) * 5 / 9
                temperatureLabel.text = String(format: NSLocalizedString("%.f℉", comment: ""), fahrenheitTemperature)
            
            case false:
                temperatureLabel.text = String(format: "%.f°", temperature)
        }
    }
    
    // MARK: - Setup view
    
    var isShowActivityIndicator: Bool = false {
        didSet {
            switch isShowActivityIndicator {
                case true:
                    activityIndicator.startAnimating()
                
                case false:
                    activityIndicator.stopAnimating()
            }
        }
    }
    
    func update(with weather: Weather) {
        self.temperature = weather.temperature
        
        cityLabel.text = weather.city
        countryLabel.text = weather.country
        weatherDescriptionLabel.text = weather.description
        temperatureLabel.text = String(format: "%.f°", weather.temperature)
        
        switch weather.temperature {
            case ...0.0:
                commentLabel.text = NSLocalizedString("It's definitely winter outside ❄️", comment: "")
            
            case 0.0...10.0:
                commentLabel.text = NSLocalizedString("Don’t forget to wear a hat! 🎩", comment: "")
            
            case 10.1...:
                commentLabel.text = NSLocalizedString("Finally summer! ⛱", comment: "")
            
            default: break
        }
    }
}
