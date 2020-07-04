//
//  WeatherPresenter.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import Foundation

protocol WeatherPresenterProtocol {
    func showWeather(for cityId: Int)
}

class WeatherPresenter: WeatherPresenterProtocol {
    unowned var ui: WeatherUIProtocol?
    
    // MARK: - Init
    
    init(ui: WeatherUIProtocol) {
        self.ui = ui
    }
    
    // MARK: - Public interface
    
    func showWeather(for cityId: Int) {
        NetworkService().weather(for: cityId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.ui?.updateView(with: weather)
                }

                case .failure(let error):
                    DispatchQueue.main.async {
                        self.ui?.show(error: error)
                }
            }
        }
    }
}
