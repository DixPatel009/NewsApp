//
//  CoreDataManager.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import CoreData
import UIKit

class CoreDataManager {
    
    // MARK: - Properties
    static let shared = CoreDataManager()
    private let entityName = "Articles"
    
    // Managed Object Context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Save Article to Core Data
    func saveArticle(_ article: Article) {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let articleEntity = NSManagedObject(entity: entity, insertInto: context)
        
        articleEntity.setValue(article.title, forKey: "title")
        articleEntity.setValue(article.description, forKey: "descriptionText")
        articleEntity.setValue(article.urlToImage, forKey: "urlToImage")
        articleEntity.setValue(article.content, forKey: "content")
        articleEntity.setValue(article.url, forKey: "url")
        articleEntity.setValue(article.publishedAt, forKey: "publishedAt")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save article: \(error), \(error.userInfo)")
        }
    }
    
    // Fetch Favorite Articles from Core Data
    func fetchFavoriteArticles() -> [Article] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let result = try context.fetch(fetchRequest)
            return result.map { articleEntity in
                Article(title: articleEntity.value(forKey: "title") as! String,
                        description: articleEntity.value(forKey: "descriptionText") as? String,
                        content: articleEntity.value(forKey: "content") as? String,
                        url: articleEntity.value(forKey: "url") as! String,
                        urlToImage: articleEntity.value(forKey: "urlToImage") as? String,
                        publishedAt: articleEntity.value(forKey: "publishedAt") as! String)
            }
        } catch let error as NSError {
            print("Failed to fetch articles: \(error), \(error.userInfo)")
            return []
        }
    }
    
    // Delete Article from Core Data
    func deleteArticle(_ article: Article) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND publishedAt == %@", article.title, article.publishedAt)
        
        do {
            let articlesToDelete = try context.fetch(fetchRequest)
            for articleEntity in articlesToDelete {
                context.delete(articleEntity)
            }
            try context.save()
        } catch let error as NSError {
            print("Failed to delete article: \(error), \(error.userInfo)")
        }
    }
    
    // Check if article is already saved in Core Data
    func isArticleInFavorites(_ article: Article) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND publishedAt == %@", article.title, article.publishedAt)
        
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Failed to check article existence: \(error.localizedDescription)")
            return false
        }
    }
}
