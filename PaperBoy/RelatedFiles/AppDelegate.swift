//
//  AppDelegate.swift
//  PaperBoy
//
//  Created by Lukas Sestic on 20/08/2018.
//  Copyright © 2018 Lukas Sestic. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let activeUsername = UserDefaults.standard.string(forKey: UserDefaultsPropertyKeys.username) ?? ""
        let usernamePredicate = NSPredicate(format: "username = %@", activeUsername)
        if activeUsername != "", let user = PersistenceService.getDataFromEntity(from: CoreDataPropertyKeys.usersEntity, with: usernamePredicate)?.first as? Users {
            let tabBarVC = UITabBarController()
            tabBarVC.tabBar.barStyle = .black
            tabBarVC.tabBar.tintColor = .neonPink

            let profileVC = ProfileViewController(for: user)
            profileVC.tabBarItem.image = UIImage(named: ViewProperties.images.profile)
            profileVC.tabBarItem.title = "Profile"

            let savedVC = SavedViewController(dataSource: SavedArticlesDataSource(), currentUser: user)
            savedVC.tabBarItem.image = UIImage(named: ViewProperties.images.saved)
            savedVC.tabBarItem.title = "Saved"

            let headlinesVC = HeadlinesViewController(dataSource: ArticlesDataSource(), currentUser: user, viewControllersToUpdate: [profileVC, savedVC])
            headlinesVC.tabBarItem.image = UIImage(named: ViewProperties.images.headlines)
            headlinesVC.tabBarItem.title = "Headlines"

            tabBarVC.setViewControllers([headlinesVC, savedVC, profileVC], animated: true)

            window?.rootViewController = tabBarVC
        }
        else {
            let navigationVC = UINavigationController(rootViewController: LoginViewController())
            navigationVC.navigationBar.tintColor = .neonPink
            navigationVC.navigationBar.barStyle = .black
            window?.rootViewController = navigationVC
        }
        
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
        // Saves changes in the application's managed object context before the application terminates.
        PersistenceService.saveContext()
    }


}

