//
//  City.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import Foundation

struct City: Decodable, Hashable {
    let id: Int
    let name: String
    let country: String
}
