//
//  FilterDataSender.swift
//  Charger App
//
//  Created by Doğukan Inci on 13.07.2022.
//

import Foundation

class FilterDataSender {
    var chargeTypesArrData = [ChargeType.ac.rawValue, ChargeType.dc.rawValue] // Charge Type data array
    var chargeTypesArrSelectedIndex = [Int]() // Charge Type selected cell Index array
    var chargeTypesArrSelectedData = [String]() // Charge Type selected cell data array
    
    var socketTypesArrData = [SocketType.type2.rawValue, SocketType.csc.rawValue, SocketType.chAdeMO.rawValue] // Socket Types data array
    var socketTypesArrSelectedIndex = [Int]() // Socket Types selected cell Index array
    var socketTypesArrSelectedData = [String]() // Socket Types selected cell data array
    
    var serviceTypesArrData = [Service.otopark.rawValue, Service.büfe.rawValue, Service.wiFi.rawValue] // Service Types data array
    var serviceTypesArrSelectedIndex = [Int]() // Service Types selected cell Index array
    var serviceTypesArrSelectedData = [String]() // Service Types selected cell data array
    
    var sliderValue: Float = 15
}
