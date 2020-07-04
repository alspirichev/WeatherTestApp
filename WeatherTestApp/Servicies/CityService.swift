//
//  CityService.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import Foundation

class CityService {
    
    func cities() -> [City] {
        guard let citiesJSON = Bundle.main.path(forResource: "city.list", ofType: "json") else {
            return [.defaultCity]
        }
        
        do {
            let citiesData = try Data(contentsOf: URL(fileURLWithPath: citiesJSON), options: [])
            let cities = try JSONDecoder().decode([City].self, from: citiesData)
            
            return cities
        } catch {
            return [.defaultCity]
        }
    }
}

extension City {
    static var defaultCity: City {
        City(id: 524894,
             name: "Moscow",
             country: "RU")
    }
}
