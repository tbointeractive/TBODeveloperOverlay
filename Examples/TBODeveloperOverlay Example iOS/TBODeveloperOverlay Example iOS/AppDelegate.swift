//
//  AppDelegate.swift
//  TBODeveloperOverlay Example iOS
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import UIKit
import TBODeveloperOverlay

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    func rootViewController() -> UIViewController {
        let viewController = UserDefaultsTableViewController(style: .grouped, userDefauts: UserDefaults.standard)
        viewController.title = "Developer Overlay"
        return viewController
    }
}
