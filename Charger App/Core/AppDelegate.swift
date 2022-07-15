//
//  AppDelegate.swift
//  Charger App
//
//  Created by Doğukan Inci on 30.06.2022.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var locationManager = LocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let loginVC = LoginViewController()
        let navViewController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navViewController
        
        return true
    }



}

