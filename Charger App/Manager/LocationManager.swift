//
//  LocationManager.swift
//  Charger App
//
//  Created by Doğukan Inci on 14.07.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    let manager: CLLocationManager?
    
    override init() {
        manager = CLLocationManager()
        super.init()
        configure()
    }
    private func configure() {
        manager?.delegate = self
        manager?.requestWhenInUseAuthorization()
    }
    func getLatitude() -> Float? {
        if let location = self.manager?.location {
            let lat = Float(location.coordinate.latitude)
            return lat
        }
        return nil
    }
    func getLongitude() -> Float? {
        if let location = self.manager?.location {
            let long = Float(location.coordinate.longitude)
            return long
        }
        return nil
    }
}

