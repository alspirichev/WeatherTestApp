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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityLabel.text = ""
        countryLabel.text = ""
        commentLabel.text = ""
        weatherDescriptionLabel.text = ""
        temperatureLabel.text = ""
    }
}
