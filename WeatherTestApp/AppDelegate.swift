//
//  AppDelegate.swift
//  WeatherTestApp
//
//  Created by Alexander Spirichev on 03.07.2020.
//  Copyright © 2020 Alexander Spirichev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "WeatherViewController", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "WeatherViewController")
        window.rootViewController = initialViewController
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

}

