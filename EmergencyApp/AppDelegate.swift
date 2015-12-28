//
//  AppDelegate.swift
//  BLETransferPOC
//
//  Created by Shah, Chintan on 12/17/15.
//  Copyright © 2015 Shah, Chintan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            
            let navigationController = UINavigationController()
            
            navigationController.navigationBar.hidden = true;
            
            let mainView = HomeViewController(nibName: "HomeViewController", bundle: nil)
            navigationController.viewControllers = [mainView]
            
            window.backgroundColor = UIColor.whiteColor()
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        
    }
    
}
