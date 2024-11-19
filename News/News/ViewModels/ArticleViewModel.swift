//
//  ArticleViewModel.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import Foundation
import UIKit

class ArticleViewModel {
    
    // MARK: - Properties
    private let repository = ArticleRepository()
    private(set) var favoriteArticles: [Article] = []
    
    // Closure for notifying the view
    var onFavoritesUpdated: (() -> Void)?
    
    // Fetch favorite articles from repository
    func fetchFavoriteArticles() {
        favoriteArticles = repository.getFavoriteArticles()
        favoriteArticles.reverse()
        onFavoritesUpdated?()
    }
    
    // Save article to favorites
    func saveArticleToFavorites(_ article: Article) {
        repository.saveArticleToFavorites(article)
        fetchFavoriteArticles()
        updateTabBarBadge()
    }
    
    // Remove article from favorites
    func removeArticleFromFavorites(_ article: Article) {
        repository.removeArticleFromFavorites(article)
        fetchFavoriteArticles()
    }
    
    // Check if the article is in favorites
    func isArticleInFavorites(_ article: Article) -> Bool {
        return repository.isArticleInFavorites(article)
    }
    
    // Clear favorite count when navigating to the Favorites page
    func clearFavorites() {
        repository.clearFavoriteCount()
        updateTabBarBadge()
    }
    
    // Update the badge based on the favorite count stored in UserDefaults
    func updateTabBarBadge() {
        let count = UserDefaultManager.shared.getFavoriteCount()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let tabBarController = appDelegate.window?.rootViewController as? TabViewController
        let favoritesTabBarItem = tabBarController?.tabBar.items?[1]
        if count > 0 {
            favoritesTabBarItem?.badgeValue = String(count)
        } else {
            favoritesTabBarItem?.badgeValue = nil
        }
    }
}
