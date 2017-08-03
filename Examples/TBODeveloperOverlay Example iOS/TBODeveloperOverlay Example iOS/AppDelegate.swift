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
        UserDefaults.standard.set(Date(), forKey: "lastAppStart")
        UserDefaults.standard.set(true, forKey: "appHasBeenStarted")
        UserDefaults.standard.set("simple string", forKey: "simpleString")
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    func rootViewController() -> UIViewController {
        let viewController = TableViewController(style: .grouped, sections: [
            Section(items: [
                Section.Item.info(title: "Info without detail text", detail: nil),
                Section.Item.info(title: "Info without detail text but with a very very long title", detail: nil),
                Section.Item.info(title: "Info", detail: "with simple detail text"),
                Section.Item.info(title: "Info", detail: "with a long detail text, that shows how the cell behaves if the text is a little longer.")
                ], title: "Information"),
            Section(items: [
                Section.Item.segue(title: "User Defaults", detail: "read only User Defaults Debugger", identifier: nil) {
                    return UserDefaultsTableViewController(style: .grouped, userDefaults: UserDefaults.standard)
                },
                Section.Item.segue(title: "User Defaults", detail: "editable User Defaults Debugger", identifier: nil) {
                    return UserDefaultsTableViewController(style: .grouped, userDefaults: UserDefaults.standard, canEdit: true)
                },
                Section.Item.segue(title: "Custom ViewController", detail: "Displays a Custom ViewController", identifier: nil) {
                    return UIViewController()
                }
                ], title: "Plugins"),
            Section(items: [
                Section.Item.action(title: "Reset", detail: "Sets a reset Date to now", identifier: nil) {
                    UserDefaults.standard.set(Date(), forKey: "lastReset")
                }
                ], title: "Actions")
            ])
        viewController.title = "Developer Overlay"
        return viewController
    }
}
