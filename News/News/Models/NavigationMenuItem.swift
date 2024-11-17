//
//  NavigationMenuItem.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

struct NavigationMenuItem {
    var id = ""
    var type: UIViewController.Type?
    var title = ""
    var icon: UIImage!
    var titleIcon: UIImage?
    var present = false
    var menuIcon: UIImage = UIImage(named: Images.TabNavigation.search)!
    var adjustScrollViewInsets = true
    var storyboardIdentifier: String?
    var onSelected: (() -> Void)?
}
