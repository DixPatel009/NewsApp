//
//  ArticleViewModel.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import Foundation

class ArticleViewModel {
    
    private let repository = ArticleRepository()
    private(set) var favoriteArticles: [Article] = []
    
    // Closure for notifying the view
    var onFavoritesUpdated: (() -> Void)?
    
    // Fetch favorite articles from repository
    func fetchFavoriteArticles() {
        favoriteArticles = repository.getFavoriteArticles()
        onFavoritesUpdated?()
    }
    
    // Save article to favorites
    func saveArticleToFavorites(_ article: Article) {
        repository.saveArticleToFavorites(article)
        fetchFavoriteArticles()
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
}
