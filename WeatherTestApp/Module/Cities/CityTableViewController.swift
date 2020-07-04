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
    
    private var allCities: [City]!
    private var sections: [Section] = []
    private let weatherSegueIdentifier = "showWeather"
    
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var filteredCities: [City] = []
    
    private var isFiltering: Bool {
        searchController.isActive && !isSearchBarEmpty
    }
    
    private var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        loadCities()
        setupSearchBar()
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
    
    // MARK: - Private methods
    
    private func loadCities() {
        allCities = CityService().cities()
        
        let groupedCities = Dictionary(grouping: allCities) { $0.country.first! }
        let keys = groupedCities.keys.sorted()
        
        sections = keys
            .map {
                Section(letter: String($0),
                        cities: groupedCities[$0]!
                            .sorted { $0.country.localizedCaseInsensitiveCompare($1.country) == .orderedAscending }
                )
        }
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search city", comment: "")
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func filterContentForSearchText(_ searchText: String, city: City? = nil) {
        filteredCities = allCities.filter { city in
            city.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}

// MARK: - UISearchResultsUpdating
extension CityTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

// MARK: - Data source
extension CityTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard isFiltering else {
            return sections.count
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isFiltering else {
            return sections[section].cities.count
        }
        return filteredCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator

        let city: City
        if isFiltering {
            city = filteredCities[indexPath.row]
        } else {
            city = sections[indexPath.section].cities[indexPath.row]
        }
        
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.country

        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard isFiltering else {
            return sections.map { $0.letter }
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard isFiltering else {
            return sections[section].letter
        }
        return nil
    }
}

// MARK: - UITableViewDelegate
extension CityTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cityId: Int
        if isFiltering {
            cityId = filteredCities[indexPath.row].id
        } else {
            cityId = sections[indexPath.section].cities[indexPath.row].id
        }
        
        performSegue(withIdentifier: weatherSegueIdentifier, sender: ["cityId": cityId])
    }
}
