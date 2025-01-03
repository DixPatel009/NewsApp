//
//  AuthRepository.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import Foundation
import Alamofire

class AuthRepository {
    
    func authenticateUser(apiKey: String, completion: @escaping (Result<Bool, APIError>) -> Void) {
        
        let parameters: [String: String] = [
            "q": "query",
            "apiKey": apiKey,
            "page": "1"
        ]
        
        let url = API.baseURL + API.everything
        
        APIManager.shared.request(
            url: url,
            method: .get,
            parameters: parameters,
            headers: nil
        ) { (result: Result<(NewsResponse, URLRequest?), APIError>) in
            switch result {
            case .success((_, _)):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
