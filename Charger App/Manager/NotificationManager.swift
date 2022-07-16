//
//  NotificationManager.swift
//  Charger App
//
//  Created by Doğukan Inci on 14.07.2022.
//

import Foundation
import UserNotifications

class NotificationManager {
    var content: UNMutableNotificationContent
    var trigger: UNNotificationTrigger?
    var notificationId: String!
    var unNotificationRequest: UNNotificationRequest!
    let center = UNUserNotificationCenter.current()
    
    init() {
        self.content = UNMutableNotificationContent()
        self.content.title = "Yaklaşan Randevu"
        self.content.body = "body"
        self.content.sound = UNNotificationSound.default
    }
    func createContent(body: String) {
        self.content.body = body
    }
    func createTrigger(trigDate: Date) {
        let date = trigDate
        var dateComponenets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponenets.timeZone = TimeZone.current
        self.trigger = UNCalendarNotificationTrigger(dateMatching: dateComponenets, repeats: false)
    }
    func createReguest(date: Date, id: String) {
        createTrigger(trigDate: date)
        self.notificationId = id
        self.unNotificationRequest = UNNotificationRequest(identifier: self.notificationId, content: self.content, trigger: self.trigger)
    }
    func addNotification() {
        center.add(unNotificationRequest)
    }
    func deleteNotification(id: String) {
        var ids = [String]()
        ids.append(id)
        center.removePendingNotificationRequests(withIdentifiers: ids)
    }
    func getNotifications(completion: @escaping ([UNNotificationRequest]) -> ()){
        center.getPendingNotificationRequests { request in
            completion(request)
        }
    }
}
