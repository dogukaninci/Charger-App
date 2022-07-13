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
        
//        filterArray.forEach { element in
//            if chargeTypesArrData.contains(element) {
//                chargeTypesArrSelectedData.append(element)
//                chargeTypesArrSelectedIndex.append(chargeTypesArrData.firstIndex(of: element)!)
//            }
//            if socketTypesArrData.contains(element) {
//                socketTypesArrSelectedData.append(element)
//                socketTypesArrSelectedIndex.append(socketTypesArrData.firstIndex(of: element)!)
//            }
//            if serviceTypesArrData.contains(element) {
//                serviceTypesArrSelectedData.append(element)
//                serviceTypesArrSelectedIndex.append(serviceTypesArrData.firstIndex(of: element)!)
//            }
//        }
    }
    
    deinit{
        // Pass data to SelectStationViewModel
        self.delegate?.sendDataToSelectStationViewModel(sendData: filterDataSender)
    }
}
