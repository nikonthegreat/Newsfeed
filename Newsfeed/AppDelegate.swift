//
//  AppDelegate.swift
//  Newsfeed
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
//        let temporaryDirectory = NSTemporaryDirectory()
//        let urlCache = URLCache(memoryCapacity: 25000000,
//                                diskCapacity: 50000000, diskPath: temporaryDirectory)
//        URLCache.shared = urlCache
        
        window = UIWindow()
        if let window = window {
            navigationController = UINavigationController(rootViewController: FeedViewController())
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

