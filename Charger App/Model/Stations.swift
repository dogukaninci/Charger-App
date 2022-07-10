//
//  Station.swift
//  Charger App
//
//  Created by Doğukan Inci on 5.07.2022.
//

import Foundation

// MARK: - StationElement
struct StationElement: Codable {
    let id: Int?
    let stationCode: String?
    let sockets: [Socket]?
    let socketCount, occupiedSocketCount: Int?
    let distanceInKM: Double?
    let geoLocation: GeoLocation?
    let services: [Service]?
    let stationName: String?
}

// MARK: - GeoLocation
struct GeoLocation: Codable {
    let longitude, latitude: Double?
    let province, address: String?
}

enum Service: String, Codable {
    case büfe = "Büfe"
    case otopark = "Otopark"
    case wiFi = "Wi-Fi"
}

// MARK: - Socket
struct Socket: Codable {
    let socketID: Int?
    let socketType: SocketType?
    let chargeType: ChargeType?
    let power: Int?
    let powerUnit: PowerUnit?
    let socketNumber: Int?
}

enum ChargeType: String, Codable {
    case ac = "AC"
    case dc = "DC"
}

enum PowerUnit: String, Codable {
    case kVa = "kVa"
    case kW = "kW"
}

enum SocketType: String, Codable {
    case chAdeMO = "CHAdeMO"
    case csc = "CSC"
    case type2 = "Type-2"
}

typealias Stations = [StationElement]

