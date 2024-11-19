//
//  AuthViewModel.swift
//  News
//
//  Created by Akabari Dixit on 19/11/24.
//

import Foundation
import Alamofire

class AuthViewModel {
    
    private var repository = AuthRepository()
    var onAuthenticationSuccess: (() -> Void)?
    var onAuthenticationFailure: ((String) -> Void)?
    
    func authenticate(apiKey: String) {
        
        repository.authenticateUser(apiKey: apiKey) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.onAuthenticationSuccess?()
            case .failure(_):
                self.onAuthenticationFailure?("API Key Invalid")
            }
        }
        
    }
    
}
