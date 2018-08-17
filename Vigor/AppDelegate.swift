//
//  AppDelegate.swift
//  Vigor
//
//  Created by Jason Shu on 6/19/18.
//  Copyright © 2018 Jason Shu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // navigation bar title font
        let navAttrs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        ]
        UINavigationBar.appearance().titleTextAttributes = navAttrs
        
        // tab bar font
        /*
        let tabAttrs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.thin)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(tabAttrs, for: .normal)
        */
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.9051012397, blue: 0.4691106677, alpha: 1)
        
        // status bar color
        //UIApplication.shared.statusBarStyle = .default
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

