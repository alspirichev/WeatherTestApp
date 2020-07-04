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
    
    @IBOutlet weak private var weatherDescriptionLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityLabel.text = ""
        countryLabel.text = ""
        commentLabel.text = ""
        weatherDescriptionLabel.text = ""
        temperatureLabel.text = ""
    }
    
    // MARK: - Setup view
    
    func update(with weather: Weather) {
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
