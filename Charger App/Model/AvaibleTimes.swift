//
//  AvaibleTimes.swift
//  Charger App
//
//  Created by Doğukan Inci on 9.07.2022.
//
import Foundation

// MARK: - Station
struct Station: Codable {
    let stationID: Int?
    let stationCode: String?
    let sockets: [SocketDay]?
    let geoLocation: GeoLocation?
    let services: [String]?
    let stationName: String?
}

// MARK: - SocketDay
struct SocketDay: Codable {
    let socketID: Int?
    let day: Day?
    let socketType, chargeType: String?
    let power, socketNumber: Int?
    let powerUnit: String?
}

// MARK: - Day
struct Day: Codable {
    let id: Int?
    let date: String?
    let timeSlots: [TimeSlot]?
}

// MARK: - TimeSlot
struct TimeSlot: Codable {
    let slot: String?
    let isOccupied: Bool?
}

