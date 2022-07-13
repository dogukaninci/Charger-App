//
//  SelectDateViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 9.07.2022.
//

import Foundation

enum DateFormat {
    case display
    case send
}

class SelectDateAndSlotViewModel {
    
    // Selected station
    let selectedStation: StationElement!
    // Station Slots
    var stationSlots: Station?
    // Closure for reload slots
    var reloadSlots: (() -> Void)?
    // Closure for reFetch data
    var reFetchData: (() -> Void)?
    
    var slots = [[Bool]]() {
        didSet {
            reloadSlots?()
        }
    }
    var date = String(){
        didSet {
            reFetchData?()
        }
    }
    var dateForDisplay = String()
    
    var selectedTimeSlot = String()
    var selectedSocketID = Int()
    var selectedSocketIndex = Int()
    
    let timeArray = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00"
                             , "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00"
                             , "19:00", "20:00", "21:00", "22:00", "23:00"]
    
    init(station: StationElement) {
        // Station info coming from SelectStationViewController
        self.selectedStation = station

        self.dateForDisplay = setDate(date: Date.now, format: .display)

        self.date = setDate(date: Date.now, format: .send)
    }
    /// Fetch avaible times from Service
    func fetchAvaibleTimes() {
        ChargerService.shared.fetchAvaibleTimes(stationID: selectedStation.id!, date: date) { [weak self] data in
            if let stationSlots = data {
                self?.stationSlots = stationSlots
                self?.saveSlots(slots: stationSlots)
            }
        }
    }
    private func saveSlots(slots: Station) {
        var allSlots: [[Bool]] = [[],[],[]]
        if let sockets = slots.sockets {
            for socketIndex in 0...sockets.count - 1 {
                if let day = sockets[socketIndex].day {
                    if let slots = day.timeSlots {
                        slots.forEach { timeSlot in
                            if let occupied = timeSlot.isOccupied {
                                allSlots[socketIndex].append(occupied)
                            }
                        }
                    }
                }
            }
            self.slots = allSlots
        }
    }
    func setDate(date: Date, format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "d MMM yyyy"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.timeZone = TimeZone.current
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        
        if format == .display {
            return dateFormatter.string(from: date)
        } else {
            return dateFormatter2.string(from: date)
        }
    }
        
}
extension SelectDateAndSlotViewModel: DateSendingDelegateProtocol {
    func sendDataToSelectDateViewModel(date: String, dateForDisplay: String) {
        // Set dateForDisplay first because didset is in the date variable,
        // if date sets first then dateForDisplay will be empty
        self.dateForDisplay = dateForDisplay
        self.date = date
    }
}
