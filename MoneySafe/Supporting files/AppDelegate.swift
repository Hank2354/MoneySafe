//
//  AppDelegate.swift
//  MoneySafe
//
//  Created by Vladislav Mashkov on 17.12.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func welcomeBlockStarting() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let vc = WelcomeController(collectionViewLayout: layout)
        
        window?.rootViewController = vc
    }
    
    func startingSetupBlockStarting() {
        
        let startingRouter = AddCashRouter.start()
        
        let vc = startingRouter.entryPoint
        
        let navigationController = UINavigationController(rootViewController: vc!)
        
        window?.rootViewController = navigationController
    }
    
    func mainBlockStarting() {
        let startingRouter = MainRouter.start()
        
        let vc = startingRouter.entryPoint
        
        let navigationController = UINavigationController(rootViewController: vc!)
        
        window?.rootViewController = navigationController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let firstLoadKey = UserDefaults.standard.bool(forKey: "firstLoad")
        let startSetupKey = UserDefaults.standard.bool(forKey: "startSetup")

        if !firstLoadKey {
            welcomeBlockStarting()
        }

        if firstLoadKey, !startSetupKey {
            startingSetupBlockStarting()
        }

        if firstLoadKey, startSetupKey {
            mainBlockStarting()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }

    
}

