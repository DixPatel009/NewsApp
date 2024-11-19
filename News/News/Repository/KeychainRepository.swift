//
//  KeychainRepository.swift
//  News
//
//  Created by Akabari Dixit on 17/11/24.
//

protocol KeychainRepositoryProtocol {
    func saveData(value: String, forKey key: String) -> Bool
    func getData(forKey key: String) -> String?
    func deleteData(forKey key: String) -> Bool
    func removeAllData() -> Bool
}

class KeychainRepository: KeychainRepositoryProtocol {
    func saveData(value: String, forKey key: String) -> Bool {
        return KeychainManager.shared.save(value, for: key)
    }

    func getData(forKey key: String) -> String? {
        return KeychainManager.shared.get(for: key)
    }

    func deleteData(forKey key: String) -> Bool {
        return KeychainManager.shared.delete(for: key)
    }
    
    func removeAllData() -> Bool {
        return KeychainManager.shared.removeAll()
    }
}
