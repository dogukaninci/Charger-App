//
//  SelectCityViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 2.07.2022.
//

import Foundation

class SelectCityViewModel {
    var cities = [String]() {
        didSet {
            reloadTableView?()
        }
    }
    var filteredCities = [String]() {
        didSet {
            reloadTableView?()
        }
    }
    private var convertedSearchText = String()
    private var transformedCities = [String]()
    private var indexSet = [Int]()
    var reloadTableView: (() -> Void)?
    
    /// Fetch Cities Array from Service
    func fetchCities() {
        ChargerService.shared.fetchCities { [weak self] citiesArray in
            if let citiesArray = citiesArray {
                self?.cities = citiesArray
                self?.filteredCities = citiesArray
            }
        }
    }
    /// Filter cities array using search bar text
    /// - Parameter searchBarText: String
    func filterArrayViaSearchBarText(searchBarText: String) {
        self.convertedSearchText = searchBarText.localizedLowercase.convertTurkishCharacterToEnglishCharacter()
        self.transformedCities = cities.map { $0.localizedLowercase.convertTurkishCharacterToEnglishCharacter() }
        self.indexSet = transformedCities.indices.filter {transformedCities[$0].hasPrefix(convertedSearchText)}
        self.filteredCities = indexSet.map { cities[$0] }

    }
}
extension String {
    func convertTurkishCharacterToEnglishCharacter() -> String{
        return self.replacingOccurrences(of: "ç", with: "c")
            .replacingOccurrences(of: "ğ", with: "g")
            .replacingOccurrences(of: "ı", with: "i")
            .replacingOccurrences(of: "ö", with: "o")
            .replacingOccurrences(of: "ü", with: "u")
            .replacingOccurrences(of: "ş", with: "s")
    }
}
