//
//  AppDelegate.swift
//  ToDoTutorial
//
//  Created by Trevor Spina on 8/2/18.
//  Copyright © 2018 TrevorSpina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let mainVC = storyboard.instantiateViewController(withIdentifier: "main tab controller") as! TabBarNavigationViewController
        let statusVC: TaskListViewController? = storyboard.instantiateViewController(withIdentifier: "status view controller") as? TaskListViewController
        let statusVCNC = UINavigationController(rootViewController: statusVC!)
        statusVC?.title = "By status"
        statusVC?.tabBarItem.image = UIImage(named: "navbar-status")
        
        let inboxVC: InboxViewController? = storyboard.instantiateViewController(withIdentifier: "inbox view controller") as? InboxViewController
        let inboxVCNC = UINavigationController(rootViewController: inboxVC!)
        inboxVC?.title = "Inbox"
        inboxVC?.tabBarItem.image = UIImage(named: "navbar-inbox")
        
        let settingsVC: SettingsViewController? = storyboard.instantiateViewController(withIdentifier: "settings view controller") as? SettingsViewController
        let settingsVCNC = UINavigationController(rootViewController: settingsVC!)
        settingsVC?.title = "Settings"
        settingsVC?.tabBarItem.image = UIImage(named: "navbar-settings")
        
        let contextVC: ContextViewController? = storyboard.instantiateViewController(withIdentifier: "context view controller") as? ContextViewController
        let contextVCNC = UINavigationController(rootViewController: contextVC!)
        contextVC?.title = "Context"
        contextVC?.tabBarItem.image = UIImage(named: "navbar-context")
        
        
        mainVC.viewControllers = [inboxVCNC, statusVCNC, contextVCNC, settingsVCNC]
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
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

