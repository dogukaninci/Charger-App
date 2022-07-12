//
//  Appointment.swift
//  Charger App
//
//  Created by Doğukan Inci on 10.07.2022.
//

import Foundation

// MARK: - Appointment
struct Appointment: Codable {
    let time, date: String?
    let stationClass: StationClass?
    let stationCode, stationName: String?
    let userID, appointmentID, socketID: Int?
    let hasPassed: Bool?
}

// MARK: - StationClass
struct StationClass: Codable {
    let id: Int?
    let stationCode: String?
    let sockets: [Socket]?
    let socketCount, occupiedSocketCount: Int?
    let distanceInKM: Double?
    let geoLocation: GeoLocation?
    let services: [String]?
    let stationName: String?
}
