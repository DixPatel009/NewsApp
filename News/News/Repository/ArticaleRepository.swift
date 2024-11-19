//
//  ArticaleRepository.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

class ArticleRepository {
    
    private let coreDataManager = CoreDataManager.shared
    
    // Save an article to the favorites
    func saveArticleToFavorites(_ article: Article) {
        coreDataManager.saveArticle(article)
        
        //Update the badge count in Userdefaults
        UserDefaultManager.shared.incrementFavoriteCount()
    }
    
    // Fetch favorite articles
    func getFavoriteArticles() -> [Article] {
        return coreDataManager.fetchFavoriteArticles()
    }
    
    // Delete an article from favorites
    func removeArticleFromFavorites(_ article: Article) {
        coreDataManager.deleteArticle(article)
    }
    
    // Check if article is already in favorites
    func isArticleInFavorites(_ article: Article) -> Bool {
        coreDataManager.isArticleInFavorites(article)
    }
    
    // Clear fovrites count from userdefaults when user visite favorite page
    func clearFavoriteCount() {
        UserDefaultManager.shared.clearFavoriteCount()
    }
}
