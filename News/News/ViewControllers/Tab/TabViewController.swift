//
//  TabViewController.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTabbar()
        self.setUpMenu()
    }
    
    private func setUpTabbar() {
        self.view.clipsToBounds = false
        view.backgroundColor = UI.Colors.backGroundColor
        tabBar.isTranslucent = false
        if #available(iOS 15.0, *){
            let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .black
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    private func setUpMenu() {
        let navigationMenuViewModel = NavigationMenuViewModel()
        
        var tabBarItemControllers:[UIViewController] = []
        var tagIndex = 0
        for menuItem in navigationMenuViewModel.tabBarItems {
            let controller = viewController(for: menuItem)
            controller.tabBarItem = UITabBarItem(title: menuItem.title, image: menuItem.icon, tag: tagIndex)
            tabBarItemControllers.append(UINavigationController(rootViewController: controller))
            tagIndex += 1
        }
        viewControllers = tabBarItemControllers
        tabBar.barStyle = .black
        tabBar.tintColor = UI.Colors.coreBlue
        delegate = self
    }
    
    private func viewController(for menuItem: NavigationMenuItem) -> UIViewController {
        if let identifier = menuItem.storyboardIdentifier {
            return UIStoryboard(name: identifier, bundle: nil).instantiateViewController(withIdentifier: identifier)
        } else {
            return menuItem.type!.init()
        }
    }
    
}

extension TabViewController : UITabBarControllerDelegate {
    
}
