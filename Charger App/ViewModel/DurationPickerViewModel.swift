//
//  DurationPickerViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 14.07.2022.
//

import Foundation
/// Delegate Protocol
protocol DurationSendingDelegateProtocol {
    func sendDataToAppointmentDetailViewModel(duration: String)
}
class DurationPickerViewModel {
    var delegate: DurationSendingDelegateProtocol? = nil
    
    var timeArray = [String]()
    var duration = String()
    
    init() {
        timeArray = [
        "5 dakika önce",
        "10 dakika önce",
        "15 dakika önce",
        "30 dakika önce",
        "1 saat önce",
        "2 saat önce",
        "3 saat önce",
        ]
    }
    deinit{
        // Pass data to AppointmentDetailViewController
        self.delegate?.sendDataToAppointmentDetailViewModel(duration: duration)
    }
    func saveDuration(duration: String) {
        self.duration = duration
    }
}
