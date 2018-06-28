//
//  AppDelegate.swift
//  Carwash
//
//  Created by Mukhamedjan on 23.06.18.
//  Copyright © 2018 sdu. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        return true
    }

    


}

