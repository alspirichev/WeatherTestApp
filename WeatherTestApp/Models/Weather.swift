//
//  Weather.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import Foundation

struct Weather {
    var temperature: Double
    var city: String
    var country: String
    var description: String
}

extension Weather: Decodable {
    enum WeatherKeys: String, CodingKey {
        case main
    }
    
    enum MainKeys: String, CodingKey {
        case temp
    }
    
    enum SysKeys: String, CodingKey {
        case country
    }
    
    enum GeneralKeys: String, CodingKey {
        case name
        case main
        case sys
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GeneralKeys.self)
        city = try container.decode(String.self, forKey: .name)
        
        let mainContainer = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try mainContainer.decode(Double.self, forKey: .temp)
        
        let sysConainer = try container.nestedContainer(keyedBy: SysKeys.self, forKey: .sys)
        country = try sysConainer.decode(String.self, forKey: .country)
        
        var weatherUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        
        var shortDescriptions = [String]()
        while !weatherUnkeyedContainer.isAtEnd {
            let weatherContainer = try weatherUnkeyedContainer.nestedContainer(keyedBy: WeatherKeys.self)
            shortDescriptions.append(try weatherContainer.decode(String.self, forKey: .main))
        }
        guard let description = shortDescriptions.first else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath + [GeneralKeys.weather],
                                                                    debugDescription: "description cannot be empty"))
        }
        self.description = description
    }
}
