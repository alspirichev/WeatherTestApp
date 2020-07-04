//
//  WeatherViewController.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 03.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import UIKit

protocol WeatherUIProtocol: class {
    func updateView(with weather: Weather)
    func show(error: NetworkService.Error)
}

class WeatherViewController: UIViewController, ViewSpecificController {
    typealias RootView = WeatherView

    var cityId: Int!
    var presenter: WeatherPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        presenter = WeatherPresenter(ui: self)
        
        view().isShowActivityIndicator = true
        presenter.showWeather(for: cityId)
    }
}

// MARK: - WeatherUIProtocol

extension WeatherViewController: WeatherUIProtocol {
    func show(error: NetworkService.Error) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""),
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""),
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func updateView(with weather: Weather) {
        view().isShowActivityIndicator = false
        view().update(with: weather)
    }
}
