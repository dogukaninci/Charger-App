//
//  DatePickerViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 9.07.2022.
//

import Foundation

/// Delegate Protocol
protocol DateSendingDelegateProtocol {
    func sendDataToSelectDateViewModel(date: String, dateForDisplay: String)
}

class DatePickerViewModel {
    var delegate: DateSendingDelegateProtocol? = nil
    
    var date = String()
    var dateForDisplay = String()
    
    deinit{
        // Pass data to SelectDateViewModel
        self.delegate?.sendDataToSelectDateViewModel(date: date, dateForDisplay: dateForDisplay)
    }
    func saveDate(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = dateFormatter.string(from: date)
        let dateFormatter2 = DateFormatter()
        dateFormatter2.timeZone = TimeZone.current
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.dateFormat = "d MMM yyyy"
        self.dateForDisplay = dateFormatter2.string(from: date)
    }
}

