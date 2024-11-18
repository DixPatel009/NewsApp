//
//  NewsRepository.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import Foundation

protocol NewsRepositoryProtocol {
    func fetchNews(query: String,
                   fromDate: String?,
                   toDate: String?,
                   page: Int,
                   completion: @escaping (Result<([Article], URLRequest?), APIError>) -> Void)
}

class NewsRepository: NewsRepositoryProtocol {
    
    func fetchNews(query: String,
                   fromDate: String?,
                   toDate: String?,
                   page: Int,
                   completion: @escaping (Result<([Article], URLRequest?), APIError>) -> Void) {
        
        let viewModel = KeychainViewModel()
        guard let apiKey = viewModel.fetchData(forKey: Constants.KeychainKey.apiKey),
              apiKey != "" else {
            completion(.failure(APIError.apiKeyNotFound))
            return
        }
        
        var parameters: [String: String] = [
            "q": query,
            "apiKey": apiKey,
            "page": "\(page)"
        ]
        
        if let fromDate = fromDate {
            parameters["from"] = fromDate
        }
        
        if let toDate = toDate {
            parameters["to"] = toDate
        } else {
            parameters["to"] = Date().stringFromDate()
        }
        
        print(parameters)
        APIManager.shared.request(
            url: API.baseURL,
            method: .get,
            parameters: parameters,
            headers: nil
        ) { (result: Result<(NewsResponse, URLRequest?), APIError>) in
            switch result {
            case .success((let newsResponse, let request)):
                completion(.success((newsResponse.articles, request)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
