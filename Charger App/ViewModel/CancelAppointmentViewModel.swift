//
//  CancelAppointmentViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 14.07.2022.
//

import Foundation

class CancelAppointmentViewModel {
    
    var appointment: Appointment!
    
    init(appointment: Appointment) {
        // Appointment info coming from AppointmentsViewController
        self.appointment = appointment
    }
    func getDateWithFormat(date: String) -> String{
        let dateFormatter2 = DateFormatter()
        dateFormatter2.timeZone = TimeZone.current
        dateFormatter2.locale = NSLocale.current
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        let dateWithFormat = dateFormatter2.date(from: date)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: dateWithFormat)
    }
}
