//
//  AppDelegate.swift
//  CoredataExperiment
//
//  Created by Banerjee, Subhodip on 12/07/18.
//  Copyright © 2018 Subhodip. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        setUpRootView()
        return true
    }
    
    func setUpRootView(){
        let vc = ViewController()
        let navigationController = CustomNavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
    }
    
}

