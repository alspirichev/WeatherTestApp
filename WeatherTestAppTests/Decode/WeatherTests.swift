//
//  WeatherTests.swift
//  WeatherTestAppTests
//
//  Created by Alexander Spirichev on 05.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import XCTest
@testable import WeatherTestApp

class WeatherTests: XCTestCase {
    func test_whenDecodeJSON_shouldReturnCorrectWeatherModel() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "weather", withExtension: "json"),
            let testData = try? Data(contentsOf: url) else {
                XCTFail("Test file is not found or corrupted")
                return
        }
        
        let weather = try XCTUnwrap(JSONDecoder().decode(Weather.self, from: testData))
        
        XCTAssertEqual(weather.temperature, 19.85)
        XCTAssertEqual(weather.city, "Moscow")
        XCTAssertEqual(weather.country, "RU")
        XCTAssertEqual(weather.description, "Clouds")
    }
}
