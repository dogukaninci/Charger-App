//
//  AppointmentsViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 10.07.2022.
//

import Foundation

class AppointmentsViewModel {
    
    var userID = Int()
    var appointments = [[Appointment]]() {
        didSet {
            reloadTableView?()
        }
    }
    // Closure for reload table view
    var reloadTableView: (() -> Void)?
    /// Check Appointments
    func checkAppointments() {
        ChargerService.shared.checkAppointments { [weak self] appointments in
            var hasPassed: [Appointment] = []
            var notPassed: [Appointment] = []
            if let appointmentsArray = appointments {
                appointmentsArray.forEach { appointment in
                    if (appointment.hasPassed!) {
                        hasPassed.append(appointment)
                    } else {
                        notPassed.append(appointment)
                    }
                }
                var temp: [[Appointment]] = []
                temp.append(notPassed)
                temp.append(hasPassed)
                self?.appointments = temp
            }
        }
    }
    /// Check Appointments
    func deleteAppointment(appointmentNumber: Int, completion: @escaping (Bool) -> ()) {
        if let appointmentID = appointments[0][appointmentNumber].appointmentID {
            ChargerService.shared.deleteApoointment(appointmentID: appointmentID, completion: { [weak self] isSuccess in
                if isSuccess {
                    self?.appointments[0] = (self?.appointments[0].filter({ $0.appointmentID != appointmentID}))!
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
}
