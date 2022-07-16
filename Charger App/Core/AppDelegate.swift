//
//  AppDelegate.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit
import CoreLocation
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var locationManager = LocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else { return }
            print("Success in ANS registry")
        }
        
        let loginVC = LoginViewController()
        let navViewController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navViewController
        
        return true
    }



}

