//
//  AppDelegate.swift
//  News
//
//  Created by Akabari Dixit on 16/11/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureLaunchAnimation()
        return true
    }
}

// MARK: - Config Launch Animation
extension AppDelegate {
    
    func configureLaunchAnimation() {
        let launchScreenContainer = LaunchScreenViewController()
        launchScreenContainer.animationCompletion = { [weak self] in
            guard let strongSelf = self else { return }
//            strongSelf.godzilaModeViewModel?.isEnabled == true ? strongSelf.configureClearStreamViewController() : strongSelf.jailbreakDetection()
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = launchScreenContainer
        window?.makeKeyAndVisible()
    }
    
}
