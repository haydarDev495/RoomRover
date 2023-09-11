//
//  AppDelegate.swift
//  RoomRover
//
//  Created by Haydar Bekmuradov on 11.09.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // - Window
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

// MARK: -
// MARK: Configure
private extension AppDelegate {
    
    func configure() {
        configureWindow()
    }
    
    func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        let vc = UIStoryboard(name: "MyLaunch", bundle: nil).instantiateInitialViewController() as! MyLaunchVC
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
