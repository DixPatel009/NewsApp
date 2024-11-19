//
//  UserDefaultManager.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import Foundation

class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    
    private init() {}
    
    // Retrive the current favorite count
    func getFavoriteCount() -> Int {
        return UserDefaults.standard.integer(forKey: Strings.userDefault.favoriteCount)
    }
    
    // Increment the favorite count
    func incrementFavoriteCount() {
        let currentCount = getFavoriteCount()
        UserDefaults.standard.setValue(currentCount + 1, forKey: Strings.userDefault.favoriteCount)
    }
    
    // Clear the favorite count
    func clearFavoriteCount() {
        UserDefaults.standard.removeObject(forKey: Strings.userDefault.favoriteCount)
    }
}
