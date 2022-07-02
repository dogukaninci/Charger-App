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
    var reloadTableView: (() -> Void)?
    
    func fetchCities() {
        ChargerService.shared.fetchCities { [weak self] citiesArray in
            if let citiesArray = citiesArray {
                self?.cities = citiesArray
            }
        }
    }
}
