//
//  AppDelegate.swift
//  News
//
//  Created by Akabari Dixit on 16/11/24.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureLaunchAnimation()
        setUpKeyboard()
        return true
    }
}

// MARK: - Setup

extension AppDelegate {
    
    private func setUpKeyboard() {
        IQKeyboardManager.shared.enable = true
    }
    
}

// MARK: - Config Root View

extension AppDelegate {
    
    private func configureLaunchAnimation() {
        let launchScreenContainer = LaunchScreenViewController()
        launchScreenContainer.userAlreadyLoggedIn = { [weak self] isAlreadyLoggedIn in
            guard let strongSelf = self else { return }
            isAlreadyLoggedIn ? strongSelf.configureMainViewController() : strongSelf.configureLoginViewController()
        }
        self.createRootViewController(viewController: launchScreenContainer)
    }
    
    private func configureLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.loginSucessfull = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.configureMainViewController()
        }
        self.createRootViewController(viewController: loginViewController)
    }
    
    private func createRootViewController(viewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    private func configureMainViewController() {
        DispatchQueue.main.async {
            self.window!.rootViewController = TabViewController()
        }
    }
        
}
