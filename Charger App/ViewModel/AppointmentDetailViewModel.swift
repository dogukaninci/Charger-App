//
//  AppointmenDetailViewModel.swift
//  Charger App
//
//  Created by Doğukan Inci on 11.07.2022.
//

import Foundation

class AppointmentDetailViewModel {
    
    var cellText = [[String]]()
    let selectedStation: StationElement!
    var selectedSocket = Int()
    var date = String()
    var timeSlot = String()
    var socketID = Int()
    var placeholderArray: [[String]] = [[],[],[]]
    var reloadTableView: (() -> Void)?
    var notificationTime = "30 dakika önce" {
        didSet {
            reloadTableView?()
        }
    }
    
    init(station: StationElement, socketIndex: Int, timeSlot: String, appointmentDate: String) {
        // Station info coming from SelectDateAndSlotViewController
        self.selectedStation = station
        self.selectedSocket = socketIndex
        self.date = appointmentDate
        self.timeSlot = timeSlot
        self.socketID = station.sockets![socketIndex].socketID!
        initCellText()
    }
    func getAddress() -> String {
        placeholderArray[0].append("Adres")
        return selectedStation.geoLocation!.address!
    }
    func getServiceTime() -> String {
        placeholderArray[0].append("Hizmet Saatleri")
        return "24 Saat"
    }
    func getDistance() -> String {
        placeholderArray[0].append("Uzaklık")
        return String(format: "%1.1f km", selectedStation.distanceInKM ?? 0)
    }
    func getStationCode() -> String {
        placeholderArray[0].append("İstasyon Kodu")
        return selectedStation.stationCode!
    }
    func getServices() -> String {
        placeholderArray[0].append("Hizmetler")
        return flatServiceArray(services: selectedStation.services!)
    }
    func getSocketNumber() -> String {
        placeholderArray[1].append("Soket Numarası")
        return String(selectedStation.sockets![selectedSocket].socketNumber!)
    }
    func getChargeType() -> String {
        placeholderArray[1].append("Cihaz Tipi")
        return selectedStation.sockets![selectedSocket].chargeType!.rawValue
    }
    func getSocketType() -> String {
        placeholderArray[1].append("Soket Tipi")
        return selectedStation.sockets![selectedSocket].socketType!.rawValue
    }
    func getPower() -> String {
        placeholderArray[1].append("Çıkış Gücü")
        return String(selectedStation.sockets![selectedSocket].power!) + " " + selectedStation.sockets![selectedSocket].powerUnit!.rawValue
    }
    func getDate() -> String {
        placeholderArray[2].append("Tarih")
        return date
    }
    func getTime() -> String {
        placeholderArray[2].append("Saat")
        return timeSlot
    }
    func getAppointmentDuration() -> String {
        placeholderArray[2].append("Randevu Süresi")
        return "1 Saat"
    }
    private func setNotification() {
        placeholderArray[2].append("Bildirim Al")
    }
    func setupNotification() {
        placeholderArray[2].append("")
        reloadTableView?()
    }
    func clearNotification() {
        placeholderArray[2].removeLast()
        reloadTableView?()
    }
    private func flatServiceArray(services: [Service]) -> String{
        var result = [String]()
        services.forEach { service in
            result.append("\(service.rawValue)")
        }
        return result.joined(separator: ",")
    }
    private func initCellText() {
        var firstSection = [String]()
        firstSection.append(getAddress())
        firstSection.append(getServiceTime())
        firstSection.append(getDistance())
        firstSection.append(getStationCode())
        firstSection.append(getServices())
        cellText.append(firstSection)
        
        var secondSection = [String]()
        secondSection.append(getSocketNumber())
        secondSection.append(getChargeType())
        secondSection.append(getSocketType())
        secondSection.append(getPower())
        cellText.append(secondSection)
        
        var thirdSection = [String]()
        thirdSection.append(getDate())
        thirdSection.append(getTime())
        thirdSection.append(getAppointmentDuration())
        cellText.append(thirdSection)
        setNotification()
    }
    func sendAppointmentRequest(completion: @escaping (Bool) -> Void) {
        ChargerService.shared.sendAppointmentRequest(stationID: selectedStation.id!, socketID: socketID, timeSlot: timeSlot, appointmentDate: date) { isSuccess in
            completion(isSuccess)
        }
    }
}
extension AppointmentDetailViewModel: DurationSendingDelegateProtocol {
    func sendDataToAppointmentDetailViewModel(duration: String) {
        self.notificationTime = duration
    }
}

