//
//  NewsViewModel.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import Foundation

class NewsViewModel {
    
    // MARK: - Properties
    private var newsRepository: NewsRepositoryProtocol
    private(set) var articles: [Article] = []
    private var currentPage = 1
    private var isLoading = false
    private var requestURL: String?

    var onNewsFetched: (() -> Void)?
    var onError: ((String) -> Void)?

    init(repository: NewsRepositoryProtocol = NewsRepository()) {
        self.newsRepository = repository
    }
    
    func fetchNews(query: String,
                   fromDate: String? = nil,
                   toDate: String? = nil,
                   reset: Bool = false) {
        
        guard !isLoading else { return }  // Prevent multiple simultaneous requests
        
        if reset {
            currentPage = 1
            articles = []
        }
        
        isLoading = true
        newsRepository.fetchNews(query: query,
                                 fromDate: fromDate,
                                 toDate: toDate,
                                 page: currentPage) { [weak self] result in
            
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success((let newArticles, let request)):
                let filteredArticles = newArticles.filter { $0.title.lowercased() != "[removed]" } // removed item remove from array
                self.articles.append(contentsOf: filteredArticles)
                self.requestURL = request?.url?.absoluteString
                self.currentPage += 1  // Increment page for next fetch
                self.onNewsFetched?()
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
        
    }
    
    func numberOfRows() -> Int {
        return articles.count
    }
    
    func article(at index: Int) -> Article {
        return articles[index]
    }
    
    func getRequestedURL() -> String? {
        return requestURL
    }
    
}
