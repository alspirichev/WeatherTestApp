//
//  City.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import Foundation

struct City: Decodable {
    let id: Int
    let name: String
    let country: String
}

extension City: Hashable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
