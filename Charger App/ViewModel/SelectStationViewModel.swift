//
//  SelectStationViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 5.07.2022.
//

import Foundation
import Alamofire

class SelectStationViewModel {
    // All stations array
    var stations = Station()
    // Final stations array shows by table view
    var filteredStations = Station() {
        didSet {
            reloadTableView?()
        }
    }
    // Stations array for exactly one city
    var filteredStationViaCity = Station()
    // Lowercased and english character transform for typo
    private var convertedSearchText = String()
    // Lowercased and english character transform for typo
    private var transformedStations = [String]()
    // Selected city
    let city: String!
    // Index matching search bar text
    private var indexSet = [Int]()
    // Closure for reload table view
    var reloadTableView: (() -> Void)?
    
    init(city: String) {
        // City info coming from SelectCityViewController
        self.city = city
    }
    
    /// Fetch Stations Array from Service
    func fetchStations() {
        ChargerService.shared.fetchStations { [weak self] stationsArray in
            if let stations = stationsArray {
                self?.stations = stations
                self?.filterByCity(stations: stations)
            }
        }
    }
    /// Table view filtering by city info
    /// - Parameter stations: Station
    private func filterByCity(stations: Station) {
        filteredStationViaCity = stations.filter({ element in
            if let stationCity = element.geoLocation?.province {
                return stationCity.hasPrefix(self.city)
            }
            return false
        })
        filteredStations = filteredStationViaCity
    }
    /// Filter stations array using search bar text
    /// - Parameter searchBarText: String
    func filterArrayViaSearchBarText(searchBarText: String) {
        if(searchBarText == "") { // Disable searching if search bar is clear
            self.filteredStations = filteredStationViaCity
        } else {
            self.convertedSearchText = searchBarText.localizedLowercase.convertTurkishCharacterToEnglishCharacter()
            self.transformedStations = filteredStationViaCity.map { $0.stationName!.localizedLowercase.convertTurkishCharacterToEnglishCharacter() }
            self.indexSet = transformedStations.indices.filter {transformedStations[$0].contains(convertedSearchText)}
            self.filteredStations = indexSet.map { filteredStationViaCity[$0] }
        }
    }
}
