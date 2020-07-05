//
//  CityTests.swift
//  WeatherTestAppTests
//
//  Created by Alexander Spirichev on 05.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import XCTest
@testable import WeatherTestApp

class CityTests: XCTestCase {
    func test_whenDecodeJSON_shouldReturnCorrectCityModel() throws {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "testCityList", withExtension: "json"),
            let testData = try? Data(contentsOf: url) else {
                XCTFail("Test file is not found or corrupted")
                return
        }
        
        let city = try XCTUnwrap(JSONDecoder().decode([City].self, from: testData).first)
        
        XCTAssertEqual(city.id, 524894)
        XCTAssertEqual(city.name, "Moscow")
        XCTAssertEqual(city.country, "RU")
    }
}
