//
//  AppDelegate.swift
//  demo.flowcontrollers
//
//  Created by Tamas Levente on 5/17/17.
//  Copyright © 2017 HalcyonMobile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flow: RootFlowController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        flow = RootFlowController(window: window)
        flow?.start()
        
        return true
    }
}

