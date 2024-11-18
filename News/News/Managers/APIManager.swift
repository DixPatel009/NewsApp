//
//  APIManager.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import Alamofire
import Foundation

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest(Error)
    case decodingError
    case apiKeyNotFound
}

class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    // Generic function to handle API calls
    func request<T: Decodable>(
        url: String,
        method: HTTPMethodType,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<(T, URLRequest?), APIError>) -> Void
    ) {
        let httpMethod: HTTPMethod
        switch method {
        case .get:
            httpMethod = .get
        case .post:
            httpMethod = .post
        case .put:
            httpMethod = .put
        case .delete:
            httpMethod = .delete
        }
        
        AF.request(url, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success((result, response.request)))
                case .failure(let error):
                    completion(.failure(.failedRequest(error)))
                }
            }
    }
}
