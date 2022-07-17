//
//  FilterViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 6.07.2022.
//

import Foundation

/// Delegate Protocol
protocol FilteringInfoSendingDelegateProtocol {
    func sendDataToSelectStationViewModel(sendData: FilterDataSender)
}
class FilterViewModel {
    var delegate: FilteringInfoSendingDelegateProtocol? = nil
    
    var filterDataSender = FilterDataSender()
    
    init(filtered: FilterDataSender) {
        // Filtered data info coming from SelectStationViewController
        self.filterDataSender = filtered
    }
    
    deinit{
        // Pass data to SelectStationViewModel
        self.delegate?.sendDataToSelectStationViewModel(sendData: filterDataSender)
    }
}
