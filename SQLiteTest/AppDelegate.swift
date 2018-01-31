//
//  AppDelegate.swift
//  SQLiteTest
//
//  Created by Nick Lin on 2018/1/31.
//  Copyright © 2018年 Nick Lin. All rights reserved.
//

import UIKit
import mLayout

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: MainVC())

        DBM.loadDB()

        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        DBM.closeDB()
    }

}
