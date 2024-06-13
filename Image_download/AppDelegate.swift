//
//  AppDelegate.swift
//  Image_download
//
//  Created by Macbook on 24/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


  
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        let vc = MainTabbar(nibName: "MainTabbar", bundle: nil)
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        

        return true
    }



}

