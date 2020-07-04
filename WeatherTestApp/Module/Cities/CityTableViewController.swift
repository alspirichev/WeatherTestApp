//
//  CityTableViewController.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 04.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    private struct Section {
        let letter : String
        let cities : [City]
    }
    
    private var sections: [Section] = []
    
    private let weatherSegueIdentifier = "showWeather"
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cities = CityService()
            .cities()
            .filter { !$0.country.isEmpty }
        
        let groupedCities = Dictionary(grouping: cities) { $0.country.first! }
        let keys = groupedCities.keys.sorted()

        sections = keys
            .map {
                Section(letter: String($0),
                        cities: groupedCities[$0]!
                            .sorted { $0.country.localizedCaseInsensitiveCompare($1.country) == .orderedAscending }
                )
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == weatherSegueIdentifier {
            let weatherViewController = segue.destination as! WeatherViewController
            
            guard let senderInfo = sender as? [String: Int],
                let cityId = senderInfo["cityId"] else {
                return
            }
            weatherViewController.cityId = cityId
        }
    }
    
}

// MARK: - Data source
extension CityTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator

        let city = sections[indexPath.section].cities[indexPath.row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.country

        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sections.map { $0.letter }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].letter
    }
}

// MARK: - UITableViewDelegate

extension CityTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cityId = sections[indexPath.section].cities[indexPath.row].id
        performSegue(withIdentifier: weatherSegueIdentifier, sender: ["cityId": cityId])
    }
}
