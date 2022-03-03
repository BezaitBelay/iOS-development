//
//  AppDelegate.swift
//  Skeleton
//
//  Created by Martin Vasilev on 1.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var apiManager: ApiManagerProtocol = APIManager.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize the window and the appCoordinator
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        
        // ApiManager
        apiManager.configure(withCacher: nil,
                             reachabilityDelegate: nil,
                             andAuthenticator: nil,
                             andUrlSwitch: nil,
                             delegate: appCoordinator as? StartLoginFlowDelegate)
        
        appCoordinator?.start()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(Notification(name: .didEnterBackground))
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(Notification(name: .willEnterForeground))
    }
}
