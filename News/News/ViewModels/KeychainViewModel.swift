//
//  KeychainViewModel.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

import Foundation

class KeychainViewModel {
    private let keychainRepository: KeychainRepositoryProtocol

    var retrievedValue: String?

    init(repository: KeychainRepositoryProtocol = KeychainRepository()) {
        self.keychainRepository = repository
    }

    func saveData(value: String, forKey key: String) -> Bool {
        return keychainRepository.saveData(value: value, forKey: key)
    }

    func fetchData(forKey key: String) -> String? {
        return keychainRepository.getData(forKey: key)
    }

    func deleteData(forKey key: String) -> Bool {
        return keychainRepository.deleteData(forKey: key)
    }
    
    func removeAllData() -> Bool {
        return keychainRepository.removeAllData()
    }
}
