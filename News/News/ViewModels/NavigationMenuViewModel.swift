//
//  NavigationMenuViewModel.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import UIKit

class NavigationMenuViewModel {
    
    let tabBarItems: [NavigationMenuItem]
    
    init() {
        tabBarItems = NavigationMenuViewModel.createBottomMenuItems()
    }
    
    static private func createBottomMenuItems() -> [NavigationMenuItem] {
        let search = createSearch()
        let favorites = createFavorites()
        let settings = createSettings()
        return [search, favorites, settings]
    }
    
    static private func createSearch() -> NavigationMenuItem {
        var home = NavigationMenuItem()
        home.id = Constants.NavigationMenu.Ids.search
        home.type = SearchViewController.self
        home.title = Strings.TabNavigation.search
        home.icon = UIImage(named: Images.TabNavigation.search)!
        return home
    }
    
    static private func createFavorites() -> NavigationMenuItem {
        var home = NavigationMenuItem()
        home.id = Constants.NavigationMenu.Ids.favorites
        home.type = FavoritesViewController.self
        home.title = Strings.TabNavigation.favorites
        home.icon = UIImage(named: Images.TabNavigation.favorites)!
        return home
    }
    
    static private func createSettings() -> NavigationMenuItem {
        var home = NavigationMenuItem()
        home.id = Constants.NavigationMenu.Ids.settings
        home.type = SettingsViewController.self
        home.title = Strings.TabNavigation.settings
        home.icon = UIImage(named: Images.TabNavigation.settings)!
        return home
    }
    
}
