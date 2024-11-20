//
//  NewsRepository.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import Foundation
import Alamofire

protocol NewsRepositoryProtocol {
    func fetchNews(query: String,
                   fromDate: String?,
                   toDate: String?,
                   sortBy: String?,
                   page: Int,
                   completion: @escaping (Result<([Article], URLRequest?), APIError>) -> Void)
}

enum APIError: Error {
    case apiKeyNotFound(String, URLRequest?)
}

class NewsRepository: NewsRepositoryProtocol {
    
    func fetchNews(query: String,
                   fromDate: String?,
                   toDate: String?,
                   sortBy: String?,
                   page: Int,
                   completion: @escaping (Result<([Article], URLRequest?), APIError>) -> Void) {
        
        let viewModel = KeychainViewModel()
        guard let apiKey = viewModel.fetchData(forKey: Constants.KeychainKey.apiKey),
              apiKey != "" else {
            completion(.failure(APIError.apiKeyNotFound(Strings.AlertMessage.notFoundKey, nil)))
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
        
        if let sortFilter = sortBy {
            parameters["sortBy"] = sortFilter.lowercased()
        }
        
        let url = API.baseURL + API.everything
        
        APIManager.shared.request(
            url: url,
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
