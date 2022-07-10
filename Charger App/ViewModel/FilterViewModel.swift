//
//  FilterViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 6.07.2022.
//

import Foundation

/// Delegate Protocol
protocol FilteringInfoSendingDelegateProtocol {
    func sendDataToSelectStationViewModel(chargeTypesArrSelectedData: [String]
                                          ,socketTypesArrSelectedData: [String]
                                          ,serviceTypesArrSelectedData: [String]
                                          ,sliderValue: Float)
}
class FilterViewModel {
    var delegate: FilteringInfoSendingDelegateProtocol? = nil
    
    var chargeTypesArrData = ["AC", "DC (Hızlı Şarj)"] // Charge Type data array
    var chargeTypesArrSelectedIndex = [Int]() // Charge Type selected cell Index array
    var chargeTypesArrSelectedData = [String]() // Charge Type selected cell data array
    
    var socketTypesArrData = ["Type 2", "CSS", "CHAdeMO"] // Socket Types data array
    var socketTypesArrSelectedIndex = [Int]() // Socket Types selected cell Index array
    var socketTypesArrSelectedData = [String]() // Socket Types selected cell data array
    
    var serviceTypesArrData = ["Otopark", "Büfe", "Wi-Fi"] // Service Types data array
    var serviceTypesArrSelectedIndex = [Int]() // Service Types selected cell Index array
    var serviceTypesArrSelectedData = [String]() // Service Types selected cell data array
    
    var sliderValue: Float = 15
    
    var filterArray = [String]()
    
    init(filtered: [String]) {
        // Filtered data info coming from SelectStationViewController
        self.filterArray = filtered
        
        filterArray.forEach { element in
            if chargeTypesArrData.contains(element) {
                chargeTypesArrSelectedData.append(element)
                chargeTypesArrSelectedIndex.append(chargeTypesArrData.firstIndex(of: element)!)
            }
            if socketTypesArrData.contains(element) {
                socketTypesArrSelectedData.append(element)
                socketTypesArrSelectedIndex.append(socketTypesArrData.firstIndex(of: element)!)
            }
            if serviceTypesArrData.contains(element) {
                serviceTypesArrSelectedData.append(element)
                serviceTypesArrSelectedIndex.append(serviceTypesArrData.firstIndex(of: element)!)
            }
        }
    }
    
    deinit{
        // Pass data to SelectStationViewModel
        self.delegate?.sendDataToSelectStationViewModel(chargeTypesArrSelectedData: chargeTypesArrSelectedData
                                                       ,socketTypesArrSelectedData: socketTypesArrSelectedData
                                                       ,serviceTypesArrSelectedData: serviceTypesArrSelectedData
                                                       ,sliderValue: sliderValue)
    }
}
